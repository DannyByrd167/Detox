import SwiftUI
import FamilyControls

@Observable
class OnboardingViewModel {
    var hasCompletedDetox: Bool = UserDefaults(suiteName: "group.com.DannyByrd.detox")?.bool(forKey: "isDetoxOver") ?? false
    
    var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    var startDate: Date? = UserDefaults.standard.object(forKey: "startTime") as? Date
    var currentDetox: DetoxType? = DetoxType(rawValue: UserDefaults.standard.string(forKey: "currentDetox") ?? "")
    var screenTimeEstimate: Int? = UserDefaults.standard.integer(forKey: "screenTimeEstimate")
    var screenTimeGoal: Set<ScreenTimeGoal> = {
        if let data = UserDefaults.standard.data(forKey: "screenTimeGoal"),
           let goals = try? JSONDecoder().decode(Set<ScreenTimeGoal>.self, from: data) {
            return goals
        }
        return Set<ScreenTimeGoal>()
    }()
    var restrictedAppsSelection: FamilyActivitySelection = {
        if let data = UserDefaults.standard.data(forKey: "restrictedApps"),
           let selection = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) {
            return selection
        }
        return FamilyActivitySelection()
    }()
    
    func saveOnboardingData(
        startDate: Date,
        detoxType: DetoxType,
        screenTimeEstimate: Int,
        screenTimeGoal: Set<ScreenTimeGoal>, // Add this
        restrictedApps: FamilyActivitySelection
    ) {
        self.startDate = startDate
        self.currentDetox = detoxType
        self.screenTimeEstimate = screenTimeEstimate
        self.screenTimeGoal = screenTimeGoal // Add this
        self.restrictedAppsSelection = restrictedApps
        self.hasCompletedOnboarding = true
        
        // Save to UserDefaults
        UserDefaults.standard.set(startDate, forKey: "startTime")
        UserDefaults.standard.set(detoxType.rawValue, forKey: "currentDetox")
        UserDefaults.standard.set(screenTimeEstimate, forKey: "screenTimeEstimate")
        if let encodedGoals = try? JSONEncoder().encode(screenTimeGoal) {
            UserDefaults.standard.set(encodedGoals, forKey: "screenTimeGoal") // Add this
        }
        if let encodedApps = try? JSONEncoder().encode(restrictedApps) {
            UserDefaults.standard.set(encodedApps, forKey: "restrictedApps")
        }
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}
