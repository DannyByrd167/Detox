//
//  OnboardingView.swift
//  Detox
//
//  Created by Danny Byrd on 1/24/25.
//

import SwiftUI
import FamilyControls

enum OnboardingScreens: Int, Codable {
    case whatsYourScreenTime = 1
    case goal = 2
    case letsGetStarted = 3
}

struct OnboardingData: Codable {
    var currentDetox: DetoxType?
    var startTime: Date?
    var hasCompletedOnboarding: Bool
    var screenTimeEstimate: Int?
    var restrictedAppsSelection: FamilyActivitySelection
}

@Observable class OnboardingInfo {
    var onboardingStage = OnboardingScreens.whatsYourScreenTime
    var currentScreenTimeEstimate: Int?
    var screenTimeGoal = Set<ScreenTimeGoal>()
    var detoxSelection: DetoxType?
    var restrictedAppsSelection = FamilyActivitySelection()
    
    func saveToUserDefaults() {
        let data = OnboardingData(
            currentDetox: detoxSelection,
            startTime: .now,
            hasCompletedOnboarding: true,
            screenTimeEstimate: currentScreenTimeEstimate,
            restrictedAppsSelection: restrictedAppsSelection
        )
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: "onboardingData")
        }
    }
}

struct OnboardingView: View {
    @Bindable var viewModel: OnboardingViewModel
    @State private var userInfo = OnboardingInfo()
    @State private var isShowingStartButton = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    Color(#colorLiteral(red: 0.216, green: 0.235, blue: 0.518, alpha: 1))
                        .ignoresSafeArea()
                    
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                                .frame(height: 33)
                                .coordinateSpace(name: "progressBar")
                            
                            HStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(#colorLiteral(red: 0.525, green: 0.431, blue: 0.898, alpha: 1)))
                                    .frame(width: (proxy.frame(in: .named("progressBar")).width - 32) * CGFloat(userInfo.onboardingStage.rawValue) / 3, height: 33)
                                
                                Spacer(minLength: 0)
                            }
                        }
                        .padding(.horizontal, 16) // Apply horizontal padding here
                        
                        switch userInfo.onboardingStage {
                        case .whatsYourScreenTime:
                            WhatsYourScreenTimeView(currentScreenTime: $userInfo.currentScreenTimeEstimate)
                                .frame(maxHeight: proxy.frame(in: .global).height * 0.8)
                        case .goal:
                            ScreenTimeGoalView(screenTimeGoals: $userInfo.screenTimeGoal)
                                .frame(maxHeight: proxy.frame(in: .global).height * 0.8)
                        case .letsGetStarted:
                            LetsGetStartedView(selectedDetox: $userInfo.detoxSelection, restrictedAppsSelection: $userInfo.restrictedAppsSelection, isShowingStartButton: $isShowingStartButton)
                                .frame(maxHeight: proxy.frame(in: .global).height)
                        }
                        
                        if userInfo.onboardingStage != .letsGetStarted || isShowingStartButton == true {
                            Button {
                                switch userInfo.onboardingStage {
                                case .whatsYourScreenTime:
                                    withAnimation {
                                        userInfo.onboardingStage = .goal
                                    }
                                case .goal:
                                    withAnimation {
                                        userInfo.onboardingStage = .letsGetStarted
                                    }
                                case .letsGetStarted:
                                    if let detoxType = userInfo.detoxSelection,
                                       let screenTimeEstimate = userInfo.currentScreenTimeEstimate {
                                        viewModel.saveOnboardingData(
                                            startDate: .now,
                                            detoxType: detoxType,
                                            screenTimeEstimate: screenTimeEstimate,
                                            screenTimeGoal: userInfo.screenTimeGoal, // Pass the goals
                                            restrictedApps: userInfo.restrictedAppsSelection
                                        )
                                        
                                        ScreenTimeManager.startDetox(type: userInfo.detoxSelection!)
                                    }
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(#colorLiteral(red: 0.525, green: 0.431, blue: 0.898, alpha: 1)))
                                    .overlay {
                                        Text(userInfo.onboardingStage == .letsGetStarted ? "Start your Detox" : "Continue")
                                            .customTextStyle(size: 32)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .padding(.horizontal)
                            }
                            .disabled(userInfo.onboardingStage == .letsGetStarted && userInfo.detoxSelection == nil)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView(viewModel: .init())
}
