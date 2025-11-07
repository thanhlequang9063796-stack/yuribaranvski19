//
//  TimerView.swift
//  Guru Barbecue
//

import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = TimerViewModel()
    @State private var showingFlipAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Configuration Section
                    if !viewModel.isRunning {
                        ConfigurationSection(viewModel: viewModel)
                            .padding()
                    }
                    
                    // Timer Display
                    TimerDisplay(viewModel: viewModel)
                        .padding()
                    
                    // Control Buttons
                    ControlButtons(viewModel: viewModel)
                        .padding()
                }
                .padding(.top)
            }
            .navigationTitle("Smart Timer")
            .onChange(of: viewModel.shouldFlip) { shouldFlip in
                if shouldFlip {
                    showingFlipAlert = true
                }
            }
            .alert("Time to Flip! 🔄", isPresented: $showingFlipAlert) {
                Button("Got it!") {
                    viewModel.resetFlipAlert()
                }
            } message: {
                Text("Turn your meat over for even cooking!")
            }
        }
    }
}

struct ConfigurationSection: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Configuration")
                    .font(.title2)
                    .fontWeight(.bold)
                
                // Meat Type
                VStack(alignment: .leading, spacing: 8) {
                    Text("Meat Type")
                        .font(.headline)
                    
                    Picker("Meat Type", selection: $viewModel.selectedMeatType) {
                        ForEach(TimerViewModel.MeatType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                // Coal Type
                VStack(alignment: .leading, spacing: 8) {
                    Text("Heat Source")
                        .font(.headline)
                    
                    Picker("Coal Type", selection: $viewModel.selectedCoalType) {
                        ForEach(TimerViewModel.CoalType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                // Temperature
                VStack(alignment: .leading, spacing: 8) {
                    Text("Temperature")
                        .font(.headline)
                    
                    Picker("Temperature", selection: $viewModel.coalTemperature) {
                        ForEach(TimerViewModel.CoalTemperature.allCases, id: \.self) { temp in
                            Text(temp.rawValue).tag(temp)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                // Meat Thickness
                VStack(alignment: .leading, spacing: 8) {
                    Text("Meat Thickness: \(String(format: "%.1f", viewModel.meatThickness)) cm")
                        .font(.headline)
                    
                    Slider(value: $viewModel.meatThickness, in: 1...8, step: 0.5)
                        .tint(.orange)
                    
                    HStack {
                        Text("1 cm")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("8 cm")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            // Estimated Time Preview
            VStack(spacing: 8) {
                Text("Estimated Cooking Time")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(viewModel.formatTime(viewModel.calculateCookingTime()))
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.orange)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(15)
        }
    }
}

struct TimerDisplay: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            // Main Timer
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                
                Circle()
                    .trim(from: 0, to: CGFloat(1 - (viewModel.timeRemaining / max(viewModel.totalTime, 1))))
                    .stroke(
                        LinearGradient(
                            colors: [.orange, .red],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: viewModel.timeRemaining)
                
                VStack(spacing: 10) {
                    Text("Cooking Time")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.formatTime(viewModel.timeRemaining))
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    if viewModel.isRunning {
                        Text("of \(viewModel.formatTime(viewModel.totalTime))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(width: 280, height: 280)
            
            // Flip Timer
            if viewModel.isRunning {
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.title2)
                        Text("Next Flip In")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    
                    Text(viewModel.formatTime(viewModel.flipTimeRemaining))
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(15)
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
        }
    }
}

struct ControlButtons: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            if !viewModel.isRunning {
                Button(action: {
                    viewModel.startTimer()
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start Cooking")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.green, .green.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(15)
                    .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
                }
            } else {
                Button(action: {
                    viewModel.stopTimer()
                }) {
                    HStack {
                        Image(systemName: "stop.fill")
                        Text("Stop")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.red, .red.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(15)
                    .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
                }
            }
        }
    }
}

#Preview {
    TimerView()
}


