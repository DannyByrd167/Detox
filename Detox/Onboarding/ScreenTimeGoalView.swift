//
//  ScreenTimeGoalView.swift
//  Detox
//
//  Created by Danny Byrd on 1/24/25.
//

import SwiftUI

enum ScreenTimeGoal: Codable {
    case improveFocus
    case buildBetterHabits
    case reclaimTime
    case improveMentalHealth
}

struct ScreenTimeGoalView: View {
    @Binding var screenTimeGoals: Set<ScreenTimeGoal>
    
    var body: some View {
        VStack {
            Text("What's Your Goal")
                .customTextStyle(size: 32)
            
            Text("Select at least one")
                .foregroundStyle(Color(#colorLiteral(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)))
                .font(.system(size: 14, weight: .medium, design: .rounded))
            
            Button {
                if screenTimeGoals.contains(.improveFocus) {
                    screenTimeGoals.remove(.improveFocus)
                } else {
                    screenTimeGoals.insert(.improveFocus)
                }
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 90)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20) .stroke(screenTimeGoals.contains(.improveFocus) ? .white : .clear, lineWidth: 5)
                            
                            HStack {
                                Spacer()
                                
                                Text("Improve Focus")
                                    .customTextStyle(size: 28)
                                
                                Spacer()
                                
                                Image(systemName: "eye")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                        }
                    }
            }
            
            Button {
                if screenTimeGoals.contains(.buildBetterHabits) {
                    screenTimeGoals.remove(.buildBetterHabits)
                } else {
                    screenTimeGoals.insert(.buildBetterHabits)
                }
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 90)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)                                .stroke(screenTimeGoals.contains(.buildBetterHabits) ? .white : .clear, lineWidth: 5)
                            
                            HStack {
                                Spacer()
                                
                                Text("Build Better Habits")
                                    .customTextStyle(size: 28)
                                
                                Spacer()
                                
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                        }
                    }
            }
            
            Button {
                if screenTimeGoals.contains(.reclaimTime) {
                    screenTimeGoals.remove(.reclaimTime)
                } else {
                    screenTimeGoals.insert(.reclaimTime)
                }
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 90)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)                  .stroke(screenTimeGoals.contains(.reclaimTime) ? .white : .clear, lineWidth: 5)
                            
                            HStack {
                                Spacer()
                                
                                Text("Reclaim Time")
                                    .customTextStyle(size: 28)
                                
                                Spacer()
                                
                                Image(systemName: "hourglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                        }
                    }
            }
            
            Button {
                if screenTimeGoals.contains(.improveMentalHealth) {
                    screenTimeGoals.remove(.improveMentalHealth)
                } else {
                    screenTimeGoals.insert(.improveMentalHealth)
                }
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 90)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)                                .stroke(screenTimeGoals.contains(.improveMentalHealth) ? .white : .clear, lineWidth: 5)
                            
                            HStack {
                                Spacer()
                                
                                Text("Improve Mental Health")
                                    .minimumScaleFactor(0.8)
                                    .customTextStyle(size: 28)
                                
                                Spacer()
                                
                                Image(systemName: "brain")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                        }
                    }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ScreenTimeGoalView(screenTimeGoals: .constant([]))
}
