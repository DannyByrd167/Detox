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
    @Binding var screenTimeGoal: ScreenTimeGoal?
    
    var body: some View {
        VStack {
            Text("What's Your Main Goal?")
                .customTextStyle(size: 32)
            
            Button {
                screenTimeGoal = .improveFocus
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 90)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20) .stroke(screenTimeGoal == .improveFocus ? .white : .clear, lineWidth: 5)
                            
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
                screenTimeGoal = .buildBetterHabits
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 90)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)                                .stroke(screenTimeGoal == .buildBetterHabits ? .white : .clear, lineWidth: 5)
                            
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
                screenTimeGoal = .reclaimTime
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 90)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)                  .stroke(screenTimeGoal == .reclaimTime ? .white : .clear, lineWidth: 5)
                            
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
                screenTimeGoal = .improveMentalHealth
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 90)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)                                .stroke(screenTimeGoal == .improveMentalHealth ? .white : .clear, lineWidth: 5)
                            
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
    ScreenTimeGoalView(screenTimeGoal: .constant(.reclaimTime))
}
