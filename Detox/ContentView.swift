//
//  ContentView.swift
//  Detox
//
//  Created by Danny Byrd on 12/26/24.

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomepageView(viewModel: .init())
                .tabItem {
                    Label("Detox", systemImage: "cloud")
                }
            
            ScreenTimeSummaryView()
                .tabItem {
                    Label("Stats", systemImage: "chart.line.text.clipboard")
                }
        }
    }
}

#Preview {
    ContentView()
}
