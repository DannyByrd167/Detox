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

import Foundation

class Detox: ObservableObject, Codable {
    @Published var detoxType: DetoxType
    @Published var startDate: Date
    @Published var currentDay: Int = 1
    @Published var detoxGoals = [DetoxGoal]()
    @Published var isActive = false
    
    init(detoxType: DetoxType, startDate: Date, currentDay: Int, detoxGoals: [DetoxGoal] = [DetoxGoal](), isActive: Bool) {
        self.detoxType = detoxType
        self.startDate = startDate
        self.currentDay = currentDay
        self.detoxGoals = detoxGoals
        self.isActive = isActive
    }
    
    enum CodingKeys: String, CodingKey {
        case detoxType
        case startDate
        case currentDay
        case detoxGoals
        case isActive
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        detoxType = try container.decode(DetoxType.self, forKey: .detoxType)
        startDate = try container.decode(Date.self, forKey: .startDate)
        currentDay = try container.decode(Int.self, forKey: .currentDay)
        detoxGoals = try container.decode([DetoxGoal].self, forKey: .detoxGoals)
        isActive = try container.decode(Bool.self, forKey: .isActive)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(detoxType, forKey: .detoxType)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(currentDay, forKey: .currentDay)
        try container.encode(detoxGoals, forKey: .detoxGoals)
        try container.encode(isActive, forKey: .isActive)
    }
}

class DetoxGoal: Codable, ObservableObject {
    @Published var name: String
    @Published var duration: Int
    @Published var isCompleted: Bool = false
    
    init(name: String, duration: Int, isCompleted: Bool = false) {
        self.name = name
        self.duration = duration
        self.isCompleted = isCompleted
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case isCompleted
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        duration = try container.decode(Int.self, forKey: .duration)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(duration, forKey: .duration)
        try container.encode(isCompleted, forKey: .isCompleted)
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
            }
        }
    }
    
    private static let deviceActivityCenter = DeviceActivityCenter()
    
    static func requestAuthorization() async {
        do {
            try await center.requestAuthorization(for: .individual)
        } catch {
            print("Failed to authorize: \(error)")
        }
    }
    
    static func setRestriction() {
        // Convert FamilyActivitySelection to ApplicationTokens
        let applications = selectionToRestrict.applicationTokens
        // Shield selected applications
        settings.shield.applications = applications
        
    }
    
    static func startDetox(detox: Detox) {
        settings.clearAllSettings()
        
        // Create a schedule based on the detox start and end dates
        let schedule = switch detox.detoxType {
        case .week:
            DeviceActivitySchedule(
                intervalStart: DateComponents(hour: 0),
                intervalEnd: DateComponents(day: 6, hour: 23, minute: 59, second: 59),
                repeats: false
            )
        case .month:
            DeviceActivitySchedule(
                intervalStart: DateComponents(hour: 0),
                intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
                repeats: true
            )
            
        default:
            DeviceActivitySchedule(
                intervalStart: DateComponents(hour: 0),
                intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
                repeats: true
            )
        }
        
        do {
            // Stop any existing monitoring
            deviceActivityCenter.stopMonitoring()
            
            // Start new monitoring
            try deviceActivityCenter.startMonitoring(
                .activity,
                during: schedule
            )
            
        } catch {
            print("DEBUG: Error starting monitoring: \(error)")
        }
    }
    
    static func removeRestriction() {
        settings.clearAllSettings()
    }
    
    func startDetox(type: DetoxType) {
        //Start Detox
        let detox = Detox(detoxType: type, startDate: .now, currentDay: 1, isActive: true)
        if let encoded = try? JSONEncoder().encode(detox) {
            UserDefaults.standard.set(encoded, forKey: "currentDetox")
            ScreenTimeManager.startDetox(detox: detox)
        } else {
            print("HELPPPPPPP needed at start detox")
        }
    }
    
    func endDetox() {
        UserDefaults.standard.removeObject(forKey: "currentDetox")
        ScreenTimeManager.removeRestriction()
    }
}
