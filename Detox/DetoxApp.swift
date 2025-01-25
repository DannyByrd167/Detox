//
//  DetoxApp.swift
//  Detox
//
//  Created by Danny Byrd on 12/26/24.
//

import SwiftUI
import FamilyControls

@main
struct DetoxApp: App {
    @State private var viewModel = OnboardingViewModel()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.hasCompletedOnboarding {
                HomepageView(viewModel: viewModel)
            } else {
                OnboardingView(viewModel: viewModel)
            }
        }
    }
}
