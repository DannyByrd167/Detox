//
//  TotalActivityView.swift
//  CustomActivityMonitorReport
//
//  Created by Danny Byrd on 12/29/24.
//

import SwiftUI
import ManagedSettingsUI
import ManagedSettings

struct TotalActivityView: View {
    let appActivities: [AppActivityReport]
    var sortedActivities: [AppActivityReport] {
        appActivities.sorted { $0.duration > $1.duration }
    }
    
    var totalDurationFormatted: String {
        let totalDurationInt = appActivities.reduce(0) { $0 + $1.duration}
        return "\(TotalActivityView.formattedDuration(totalDurationInt))"
    }
    
    var body: some View {
            LazyVGrid(columns: [GridItem(), GridItem()], content: {
                ForEach(sortedActivities.prefix(4), id: \.appName) { activity in
                    HStack {
                        Label(activity.token).labelStyle(.iconOnly)
                            .scaleEffect(3)
                        
                        Spacer()
                        
                        VStack {
                            Text(activity.appName)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                            
                            Text(TotalActivityView.formattedDuration(activity.duration))
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .padding(.leading, 5)
                    }
                    .padding()
                }
            })
            .frame(height: 150)
    }
    
    static func formattedDuration(_ duration: Int) -> String {
        let hours = duration / 3600
        let minutes = duration / 60 % 60
        
        if hours > 0 {
            return "\(hours) hr \(minutes) min"
        } else {
            return "\(minutes) min"
        }
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
#Preview {
    TotalActivityView(appActivities: [])
}
