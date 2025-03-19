//
//  ScreenTimeManager.swift
//  Detox
//
//  Created by Danny Byrd on 12/26/24.

import ManagedSettings
import DeviceActivity
import FamilyControls
import SwiftUI
import ManagedSettingsUI

extension DeviceActivityReport.Context {
    static let totalActivity = Self("Total Activity")

}

extension ManagedSettingsStore.Name {
    static let addictingApps = Self("addictingApps")
}

enum DetoxType: String, CaseIterable, Codable {
    case week = "1 Week"
    case month = "1 Month"
    case day = "1 Day"
}

extension DeviceActivityName {
    static let activity = Self("activity")
}

class Detox: ObservableObject, Codable {
    @Published var detoxType: DetoxType
    @Published var startDate: Date
    @Published var currentDay: Int = 1
    @Published var isActive = false
    
    init(detoxType: DetoxType, startDate: Date, currentDay: Int, isActive: Bool) {
        self.detoxType = detoxType
        self.startDate = startDate
        self.currentDay = currentDay
        self.isActive = isActive
    }
    
    enum CodingKeys: String, CodingKey {
        case detoxType
        case startDate
        case currentDay
        case isActive
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        detoxType = try container.decode(DetoxType.self, forKey: .detoxType)
        startDate = try container.decode(Date.self, forKey: .startDate)
        currentDay = try container.decode(Int.self, forKey: .currentDay)
        isActive = try container.decode(Bool.self, forKey: .isActive)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(detoxType, forKey: .detoxType)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(currentDay, forKey: .currentDay)
        try container.encode(isActive, forKey: .isActive)
    }
}

class ScreenTimeManager: Codable {
    static let settings = ManagedSettingsStore(named: .addictingApps)
    static let center = AuthorizationCenter.shared
    static var selectionToRestrict = FamilyActivitySelection() {
        didSet {
            let sharedDefaults = UserDefaults(suiteName: "group.com.DannyByrd.detox")
            
            // Encode and save the selection to app group
            if let encoded = try? JSONEncoder().encode(selectionToRestrict) {
                sharedDefaults?.set(encoded, forKey: "restrictedApps")
                print(sharedDefaults == nil)
                print("Successfully Encoded Apps")
            }
        }
    }
    
    private static let deviceActivityCenter = DeviceActivityCenter()
    
    static func requestAuthorization() async -> Bool {
        do {
            try await center.requestAuthorization(for: .individual)
            try await Task.sleep(nanoseconds: 100_000_000)
            if center.authorizationStatus == .approved {
                return true
            }
        } catch {
            print("Failed to authorize: \(error)")
        }
        
        return false
    }
    
    static func setRestriction() {
        // Convert FamilyActivitySelection to ApplicationTokens
        let applications = selectionToRestrict.applicationTokens
        // Shield selected applications
        settings.shield.applications = applications
        
    }
    
    static func removeRestriction() {
        settings.clearAllSettings()
        deviceActivityCenter.stopMonitoring()
    }
    
    static func startDetox(type: DetoxType) {
        //Start Detox
        settings.clearAllSettings()
        // Stop any existing monitoring
        deviceActivityCenter.stopMonitoring()
        
        
        // Create a schedule based on the detox start and end dates
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now)
        let dayLater = Date.now.addingTimeInterval(60*60*24)
        let dayLaterComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dayLater)
        
        let schedule = switch type {
        case .week:
            DeviceActivitySchedule(
                intervalStart: DateComponents(hour: 0),
                intervalEnd: DateComponents(day: 6, hour: 23, minute: 59, second: 59),
                repeats: false
            )
        case .month:
            DeviceActivitySchedule(
                intervalStart: DateComponents(hour: 0),
                intervalEnd: DateComponents(day: 30, hour: 23, minute: 59, second: 59),
                repeats: false
            )
        default:
            DeviceActivitySchedule(
                intervalStart: dateComponents,
                intervalEnd: dayLaterComponents,
                repeats: false
            )
        }
        
        do {
            // Start new monitoring
            try deviceActivityCenter.startMonitoring(
                .activity,
                during: schedule
            )
            
        } catch {
            print("DEBUG: Error starting monitoring: \(error)")
        }
    }
    
    func endDetox() {
        UserDefaults.standard.removeObject(forKey: "currentDetox")
        ScreenTimeManager.removeRestriction()
    }
}
