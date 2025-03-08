import SwiftUI
import FamilyControls

@Observable
class OnboardingViewModel {
    var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    var hasCompletedDetox: Bool = UserDefaults(suiteName: "group.com.DannyByrd.detox")?.bool(forKey: "isDetoxOver") ?? false
    var startDate: Date? = UserDefaults.standard.object(forKey: "startTime") as? Date
    var currentDetoxType: DetoxType? = DetoxType(rawValue: UserDefaults.standard.string(forKey: "currentDetox") ?? "")
    var screenTimeEstimate: Int? = UserDefaults.standard.integer(forKey: "screenTimeEstimate")
    
    var screenTimeGoal: Set<ScreenTimeGoal> = {
        if let data = UserDefaults.standard.data(forKey: "screenTimeGoal"),
           let goals = try? JSONDecoder().decode(Set<ScreenTimeGoal>.self, from: data) {
            return goals
        }
        return Set<ScreenTimeGoal>()
    }()
    
    func saveOnboardingData(
        startDate: Date,
        detoxType: DetoxType,
        screenTimeEstimate: Int,
        screenTimeGoal: Set<ScreenTimeGoal>
    ) {
        self.startDate = startDate
        self.currentDetoxType = detoxType
        self.screenTimeEstimate = screenTimeEstimate
        self.screenTimeGoal = screenTimeGoal // Add this
        self.hasCompletedOnboarding = true
        
        UserDefaults.standard.set(startDate, forKey: "startTime")
        UserDefaults.standard.set(detoxType.rawValue, forKey: "currentDetox")
        UserDefaults.standard.set(screenTimeEstimate, forKey: "screenTimeEstimate")
        if let encodedGoals = try? JSONEncoder().encode(screenTimeGoal) {
            UserDefaults.standard.set(encodedGoals, forKey: "screenTimeGoal")
        }
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}
