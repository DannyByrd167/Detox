//
//  DeviceActivityMonitorExtension.swift
//  CustomActivityMonitor
//
//  Created by Danny Byrd on 12/28/24.
//

import DeviceActivity
import ManagedSettings
import FamilyControls
import Foundation

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let addictingAppsStore = ManagedSettingsStore(named: .addictingApps)
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        let sharedDefaults = UserDefaults(suiteName: "group.com.DannyByrd.detox")
        if let savedData = sharedDefaults?.data(forKey: "restrictedApps"),
           let selection = try? JSONDecoder().decode(FamilyActivitySelection.self, from: savedData) {
            addictingAppsStore.shield.applications = selection.applicationTokens
        }
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        addictingAppsStore.shield.applications = nil
        let sharedDefaults = UserDefaults(suiteName: "group.com.DannyByrd.detox")
        sharedDefaults?.set(true, forKey: "isDetoxOver")
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
