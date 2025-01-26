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
    @ObservedObject var detox: Detox
    @State var hasCompletedDetox: Bool
    @State var isGettingMotivation = false
    
    init(viewModel: OnboardingViewModel) {
        let startDate = viewModel.startDate ?? Date.now
        let calendar = Calendar.current
        let startOfStartDay = calendar.startOfDay(for: startDate)
        let startOfNow = calendar.startOfDay(for: Date.now)
        let daysDifference = calendar.dateComponents([.day], from: startOfStartDay, to: startOfNow).day ?? 0
        let currentDay = daysDifference + 1 // Starts at 1

        detox = .init(
            detoxType: viewModel.currentDetox ?? .day,
            startDate: startDate,
            currentDay: currentDay,
            detoxGoals: [],
            isActive: false
        )
        
        hasCompletedDetox = viewModel.hasCompletedDetox
        
        checkDetox()
    }
    
    var timeSinceStartDetox: Double {
//        guard let detox else { return 0 }
        
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
                    
                    VStack {
                        VStack {
                            HStack {
                                Text("Current Detox:")
                                    .customTextStyle(size: 20)
                                
                                Spacer()
                                
                                timeSinceStartFormatted()
                                    .customTextStyle(size: 14)
                            }
                            
                            //TODO: Update Gauge For Month Detox
                            Gauge(value: timeSinceStartDetox, in: 0...604800) {}
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
                                Text("Today's Challenges:")
                                    .customTextStyle(size: 20)
                                
                                Spacer()
                            }
                            ForEach(detox.detoxGoals, id: \.name) { goal in
                                Button {
                                    //mark goal as completed
                                    withAnimation {
                                        goal.isCompleted.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: goal.isCompleted ? "checkmark.circle" : "circle")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .scaledToFit()
                                            .foregroundStyle(.white)
                                            .contentTransition(.symbolEffect)
                                        
                                        Text(goal.name)
                                            .customTextStyle(size: 24)
                                        
                                        Spacer()
                                    }
                                }
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
                                Text(isGettingMotivation ? "How are you feeling?" : "Need support?")
                                    .customTextStyle(size: 20)
                                
                                Spacer()
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
                                Text("Top apps used:")
                                    .customTextStyle(size: 20)
                                Spacer()
                            }
                            
                            ScreenTimeSummaryView()
                                .frame(height: 200)
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
            }
        }
        .sheet(isPresented: $hasCompletedDetox, onDismiss: {
            UserDefaults(suiteName: "group.com.DannyByrd.detox")?.removeObject(forKey: "hasCompletedDetox")
        }, content: {
            Color.red
        })
        .onAppear {
            checkDetox()
        }
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
    
    
    
    func checkDetox() {
        let data = UserDefaults.standard.data(forKey: "currentDetox")
        do {
            if let data {
                let decodedDetox = try JSONDecoder().decode(Detox.self, from: data)
                
                //seconds duration of detox type: e.g 1 Week = 60*60*24*7 seconds
                var timeToAdd: TimeInterval {
                    switch decodedDetox.detoxType {
                        case .week:
                            60*60*24*7
                        case .month:
                            60*60*24*30
                        case .day:
                            60*60*24
                    }
                }
                
                if (Calendar.current.compare(.now, to: decodedDetox.startDate.addingTimeInterval(timeToAdd), toGranularity: .nanosecond).rawValue > 0) {
                    print("Finished Detox")
                    
                    //TODO: Process Finishing Detox Celebration
                    ScreenTimeManager.removeRestriction()
                    UserDefaults.standard.removeObject(forKey: "currentDetox")
                } else {
                    detox.detoxType = decodedDetox.detoxType
                }
            } else {
                ScreenTimeManager.removeRestriction()
            }
            
        } catch {
            print(error)
        }
    }
}

#Preview {
    HomepageView(viewModel: .init())
}
