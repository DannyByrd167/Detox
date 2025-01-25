//
//  TotalActivityReport.swift
//  CustomActivityMonitorReport
//
//  Created by Danny Byrd on 12/29/24.
//

import DeviceActivity
import SwiftUI
import ManagedSettings

struct AppActivityReport: Identifiable {
    let id: String
    let appName: String
    let duration: Int
    let numPickups: Int
    let token: ApplicationToken
}

struct TotalActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: ([AppActivityReport]) -> TotalActivityView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> [AppActivityReport] {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
        let iterator = data.makeAsyncIterator()
        var reportsDict = [String: AppActivityReport]()
        
        while let iterator = await iterator.next() {
            let segments = iterator.activitySegments.makeAsyncIterator()
            while let segment = await segments.next() {
                let categories = segment.categories.makeAsyncIterator()
                while let category = await categories.next() {
                    let apps = category.applications.makeAsyncIterator()
                    while let app = await apps.next() {
                        let appName = app.application.localizedDisplayName ?? "No app name"
                        let duration = Int(app.totalActivityDuration)
                        let numPickups = app.numberOfPickups
                        let token = app.application.token
                        
                        // Skip system apps (usually have empty bundle IDs)
                        guard let bundleID = app.application.bundleIdentifier,
                              !bundleID.isEmpty else { continue }
                        
                        guard duration > 60 else { continue }
                        
                        // Update existing entry or create new one
                        if let existing = reportsDict[bundleID] {
                            let updatedReport = AppActivityReport(
                                id: bundleID,
                                appName: appName,
                                duration: existing.duration + duration,
                                numPickups: existing.numPickups + numPickups,
                                token: token!
                            )
                            reportsDict[bundleID] = updatedReport
                        } else {
                            let report = AppActivityReport(
                                id: bundleID,
                                appName: appName,
                                duration: duration,
                                numPickups: numPickups,
                                token: token!
                            )
                            reportsDict[bundleID] = report
                        }
                    }
                }
            }
        }
        
        return Array(reportsDict.values)
    }
        
}
