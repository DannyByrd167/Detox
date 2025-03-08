//
//  HomepageView.swift
//  Detox
//
//  Created by Danny Byrd on 12/27/24.
//

import SwiftUI

extension View {
    func customTextStyle(size: CGFloat) -> some View {
        modifier(CustomText(size: size))
    }
}

struct CustomText: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: size, weight: .bold, design: .default))
    }
}

struct HomepageView: View {
    @State var detox: Detox
    @State var hasCompletedDetox: Bool
    @State var isGettingMotivation = false
    @State var detoxTimeInterval: Int?
    
    init(viewModel: OnboardingViewModel) {
        let startDate = viewModel.startDate ?? Date.now
        let calendar = Calendar.current
        let startOfStartDay = calendar.startOfDay(for: startDate)
        let startOfNow = calendar.startOfDay(for: Date.now)
        let daysDifference = calendar.dateComponents([.day], from: startOfStartDay, to: startOfNow).day ?? 0
        let currentDay = daysDifference + 1
        
        detox = .init(
            detoxType: viewModel.currentDetoxType ?? .day,
            startDate: startDate,
            currentDay: currentDay,
            detoxGoals: [],
            isActive: false
        )
        
        switch viewModel.currentDetoxType {
        case .week:
            detoxTimeInterval = 604800
        case .month:
            detoxTimeInterval = 2592000
        case .day:
            detoxTimeInterval = 86400
        case .none:
            detoxTimeInterval = nil
        }
        
        hasCompletedDetox = viewModel.hasCompletedDetox
    }
    
    var timeSinceStartDetox: Double {
        return Double(Date().timeIntervalSince(detox.startDate))
    }

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.216, green: 0.235, blue: 0.518, alpha: 1)) // #373c84
                .ignoresSafeArea()
            
            VStack {
                Text(String(detox.currentDay))
                    .customTextStyle(size: 100)
                    .contentTransition(.numericText())
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.65))
                        
                    )
                    .padding(.vertical)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.65))
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack {
                            VStack {
                                HStack {
                                    Text("Current Detox:")
                                        .customTextStyle(size: 20)
                                    
                                    Spacer()
                                    
                                    timeSinceStartFormatted()
                                        .customTextStyle(size: 14)
                                }
                                
                                
                                Gauge(value: timeSinceStartDetox, in: 0...Double(detoxTimeInterval ?? 0)) {}
                                    .tint(Color(#colorLiteral(red: 0.051, green: 0.969, blue: 0.263, alpha: 1)))
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                                    )
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                            )
                            .padding(.horizontal)
                            .padding(.top)
                            
                            VStack {
                                HStack {
                                    Text(isGettingMotivation ? "How are you feeling?" : "Need support?")
                                        .customTextStyle(size: 20)
                                    
                                    Spacer()
                                    
                                    if isGettingMotivation {
                                        Button {
                                            withAnimation {
                                                isGettingMotivation.toggle()
                                            }
                                        } label: {
                                            Image(systemName: "x.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundStyle(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                                        }
                                    }
                                }
                                
                                if isGettingMotivation {
                                    HStack {
                                        Button {
                                            
                                        } label: {
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.5))
                                                .overlay {
                                                    VStack {
                                                        Text("😑")
                                                            .customTextStyle(size: 64)
                                                            .padding(0)
                                                        
                                                        Text("Bored")
                                                            .customTextStyle(size: 20)
                                                    }
                                                }
                                        }
                                        
                                        Button {
                                            
                                        } label: {
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.5))
                                                .overlay {
                                                    VStack {
                                                        Text("😵‍💫")
                                                            .customTextStyle(size: 64)
                                                            .padding(0)
                                                        
                                                        Text("Stressed")
                                                            .customTextStyle(size: 20)
                                                    }
                                                }
                                        }
                                        
                                        Button {
                                            
                                        } label: {
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.5))
                                            
                                                .overlay {
                                                    VStack {
                                                        Text("😰")
                                                            .customTextStyle(size: 64)
                                                            .padding(0)
                                                        
                                                        Text("Lonely")
                                                            .customTextStyle(size: 20)
                                                    }
                                                }
                                        }
                                    }
                                    .frame(height: 100)
                                } else {
                                    Button {
                                        withAnimation {
                                            isGettingMotivation.toggle()
                                        }
                                    } label: {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.5))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 60)
                                            .overlay {
                                                Text("Get some motivation")
                                                    .customTextStyle(size: 24)
                                            }
                                        
                                        
                                    }
                                    .disabled(isGettingMotivation)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                            )
                            .padding(.horizontal)
                            
                            VStack {
                                HStack {
                                    Text("Top apps used today:")
                                        .customTextStyle(size: 20)
                                    Spacer()
                                }
                                
                                ScreenTimeSummaryView()
                                    .frame(height: 170)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                            )
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                    .offset(y: 8)
                }
            }
        }
        .sheet(isPresented: $hasCompletedDetox, onDismiss: {
            print("Dismissed")
            UserDefaults(suiteName: "group.com.DannyByrd.detox")?.set(false, forKey: "hasCompletedDetox")
        }, content: {
            CompletedDetoxView()
                .interactiveDismissDisabled()
        })
    }
    
    func timeSinceStartFormatted() -> Text {
        let timeSinceStartSeconds = Int((timeSinceStartDetox))
        let timeSinceStartMinutes = (timeSinceStartSeconds / 60) % 60
        let timeSinceStartHrs = (timeSinceStartSeconds / 3600) % 24
        let timeSinceStartDays = (timeSinceStartSeconds / 86400)
        
        if timeSinceStartDays == 0 {
            return Text("\(timeSinceStartHrs) hr \(timeSinceStartMinutes) min")
        } else {
            return Text("^[\(timeSinceStartDays) day](inflect: true) \(timeSinceStartHrs) hr \(timeSinceStartMinutes) min")
        }
    }
}

#Preview {
    HomepageView(viewModel: .init())
}

