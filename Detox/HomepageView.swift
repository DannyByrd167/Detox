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
    @State var viewModel: OnboardingViewModel
    @State var detox: Detox
    @State var hasCompletedDetox: Bool
    @State var isGettingMotivation = false
    @State var detoxTimeInterval: Int?
    @State var journalVM: JournalViewModel
    @AppStorage("tip") var tip = Tip.randomTip()
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
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
        if let data = UserDefaults.standard.data(forKey: "journal\(startOfNow.formatted())") {
            do {
                let journal = try JSONDecoder().decode(JournalViewModel.self, from: data)
                self.journalVM = journal
            } catch {
                self.journalVM = JournalViewModel()
            }
        } else {
            self.journalVM = JournalViewModel()
        }
    }
    
    var timeSinceStartDetox: Double {
        return Double(Date().timeIntervalSince(detox.startDate))
    }

    var body: some View {
        NavigationStack {
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
                                    Text("Screen Time Tip:")
                                        .customTextStyle(size: 24)
                                    
                                    Text(tip)
                                        .customTextStyle(size: 20)
                                        .multilineTextAlignment(.center)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
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
                            
                            VStack {
                                NavigationLink {
                                    JournalView(vm: journalVM)
                                        .navigationBarBackButtonHidden()
                                        .onDisappear {
                                            do {
                                                withAnimation {
                                                    journalVM.hasCompletedEntry = true
                                                }
                                                let data = try JSONEncoder().encode(journalVM)
                                                let startOfToday = Calendar.current.startOfDay(for: .now).formatted()
                                                UserDefaults.standard.set(data, forKey: "journal\(startOfToday)")
                                            } catch {
                                                print("Error encoding journal: \(error.localizedDescription)")
                                            }
                                        }
                                } label: {
                                    if journalVM.hasCompletedEntry {
                                        Label("Daily Journal", image: "note.text.badge.checkmark")
                                            .customTextStyle(size: 30)
                                    } else {
                                        Label("Daily Journal", systemImage: "note.text.badge.plus")
                                            .customTextStyle(size: 30)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                            )
                            .padding(.horizontal)
                        }
                        .offset(y: 8)
                    }
                }
            }
            .fullScreenCover(isPresented: $hasCompletedDetox, onDismiss: {
                print("Dismissed")
                ScreenTimeManager.removeRestriction()
                if let defaults = UserDefaults(suiteName: "group.com.DannyByrd.detox") {
                    defaults.set(false, forKey: "isDetoxOver")
                    print("IsDetoxOver: \(defaults.bool(forKey: "isDetoxOver"))")
                    print("Finished detox")
                } else {
                    print("Didn't change")
                }
                UserDefaults.standard.removeObject(forKey: "currentDetox")
                viewModel.currentDetoxType = nil
                viewModel.hasCompletedDetox = false
                UserDefaults.standard.removeObject(forKey: "journal\(Calendar.current.startOfDay(for: Date.now).formatted())")
                journalVM = JournalViewModel()
            }, content: {
                CompletedDetoxView(length: detox.detoxType, startDate: detox.startDate)
            })
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
}

#Preview {
    HomepageView(viewModel: .init())
}

