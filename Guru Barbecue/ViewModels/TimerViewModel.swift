//
//  TimerViewModel.swift
//  Guru Barbecue
//

import Foundation
import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var selectedMeatType: MeatType = .beef
    @Published var selectedCoalType: CoalType = .charcoal
    @Published var coalTemperature: CoalTemperature = .medium
    @Published var meatThickness: Double = 3.0 // in cm
    
    @Published var isRunning = false
    @Published var totalTime: TimeInterval = 0
    @Published var timeRemaining: TimeInterval = 0
    @Published var flipTimeRemaining: TimeInterval = 40
    @Published var shouldFlip = false
    
    private var timer: Timer?
    private var flipTimer: Timer?
    private let flipInterval: TimeInterval = 40
    
    enum MeatType: String, CaseIterable {
        case beef = "Beef"
        case chicken = "Chicken"
        case lamb = "Lamb"
        case pork = "Pork"
        case fish = "Fish"
    }
    
    enum CoalType: String, CaseIterable {
        case charcoal = "Charcoal"
        case wood = "Wood"
        case gas = "Gas"
        case electric = "Electric"
    }
    
    enum CoalTemperature: String, CaseIterable {
        case low = "Low (250-300°F)"
        case medium = "Medium (300-350°F)"
        case mediumHigh = "Medium-High (350-400°F)"
        case high = "High (400-450°F)"
        case veryHigh = "Very High (450°F+)"
    }
    
    func calculateCookingTime() -> TimeInterval {
        // Base cooking time in minutes based on meat type and thickness
        var baseTime: Double = 0
        
        switch selectedMeatType {
        case .beef:
            baseTime = meatThickness * 4.0 // 4 min per cm
        case .chicken:
            baseTime = meatThickness * 5.0 // 5 min per cm
        case .lamb:
            baseTime = meatThickness * 4.5
        case .pork:
            baseTime = meatThickness * 5.5
        case .fish:
            baseTime = meatThickness * 2.5
        }
        
        // Adjust for coal type
        switch selectedCoalType {
        case .charcoal:
            baseTime *= 1.0
        case .wood:
            baseTime *= 1.1 // Slightly longer
        case .gas:
            baseTime *= 0.9 // More controlled
        case .electric:
            baseTime *= 0.95
        }
        
        // Adjust for temperature
        switch coalTemperature {
        case .low:
            baseTime *= 1.5
        case .medium:
            baseTime *= 1.2
        case .mediumHigh:
            baseTime *= 1.0
        case .high:
            baseTime *= 0.85
        case .veryHigh:
            baseTime *= 0.7
        }
        
        return baseTime * 60 // Convert to seconds
    }
    
    func startTimer() {
        totalTime = calculateCookingTime()
        timeRemaining = totalTime
        flipTimeRemaining = flipInterval
        isRunning = true
        shouldFlip = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
            }
        }
        
        flipTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.flipTimeRemaining > 0 {
                self.flipTimeRemaining -= 1
            } else {
                self.shouldFlip = true
                self.flipTimeRemaining = self.flipInterval
            }
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        flipTimer?.invalidate()
        timer = nil
        flipTimer = nil
    }
    
    func resetFlipAlert() {
        shouldFlip = false
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    deinit {
        timer?.invalidate()
        flipTimer?.invalidate()
    }
}

