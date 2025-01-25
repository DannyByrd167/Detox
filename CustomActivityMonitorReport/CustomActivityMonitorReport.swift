//
//  CustomActivityMonitorReport.swift
//  CustomActivityMonitorReport
//
//  Created by Danny Byrd on 12/29/24.
//

import DeviceActivity
import SwiftUI

@main
struct CustomActivityMonitorReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(appActivities: totalActivity)
        }
        // Add more reports here...
    }
}
