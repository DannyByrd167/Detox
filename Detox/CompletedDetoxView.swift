//
//  CompletedDetoxView.swift
//  Detox
//
//  Created by Danny Byrd on 3/7/25.
//

import SwiftUI

struct CompletedDetoxView: View {
    let length: DetoxType
    let startDate: Date
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.216, green: 0.235, blue: 0.518, alpha: 1)) // #373c84
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.white)
                    }
                }
                
                Text("Congratulations!")
                    .customTextStyle(size: 30)
                
                Text("You completed a \(length.rawValue) digital detox!")
                
                switch length {
                case .week:
                    weekSummaryView(startDate: startDate)
                case .month:
                    monthSummaryView(startDate: startDate)
                case .day:
                    daySummaryView(startDate: startDate)
                }
            }
        }
    }
}

struct daySummaryView: View {
    let startDate: Date
    var body: some View {
        Text("Hello, world")
    }
}

struct weekSummaryView: View {
    let startDate: Date
    var body: some View {
        Text("Hello, world")
    }
}

struct monthSummaryView: View {
    let startDate: Date
    var body: some View {
        Text("Hello, world")
    }
}

#Preview {
    CompletedDetoxView(length: .day, startDate: .now)
}
