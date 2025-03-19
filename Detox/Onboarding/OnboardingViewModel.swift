import SwiftUI
import FamilyControls

@Observable
class OnboardingViewModel {
    var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    var hasCompletedDetox: Bool = UserDefaults(suiteName: "group.com.DannyByrd.detox")?.bool(forKey: "isDetoxOver") ?? false
    var startDate: Date? = UserDefaults.standard.object(forKey: "startTime") as? Date
    var currentDetoxType: DetoxType? = DetoxType(rawValue: UserDefaults.standard.string(forKey: "currentDetox") ?? "")
    var screenTimeEstimate: Int? = UserDefaults.standard.integer(forKey: "screenTimeEstimate")
    
    var screenTimeGoal: ScreenTimeGoal {
        do {
            if let data = UserDefaults.standard.data(forKey: "screenTimeGoal") {
                return try JSONDecoder().decode(ScreenTimeGoal.self, from: data)
            } else {
                return .reclaimTime
            }
        } catch {
            return .reclaimTime
        }
    }
    
    func saveOnboardingData(
        startDate: Date,
        detoxType: DetoxType,
        screenTimeEstimate: Int,
        screenTimeGoal: ScreenTimeGoal
    ) {
        self.startDate = startDate
        self.currentDetoxType = detoxType
        self.screenTimeEstimate = screenTimeEstimate
        self.hasCompletedOnboarding = true
        
        UserDefaults.standard.set(startDate, forKey: "startTime")
        UserDefaults.standard.set(detoxType.rawValue, forKey: "currentDetox")
        UserDefaults.standard.set(screenTimeEstimate, forKey: "screenTimeEstimate")
        do {
            let encoded = try JSONEncoder().encode(screenTimeGoal)
            UserDefaults.standard.set(encoded, forKey: "screenTimeGoal")
        } catch {
            print("error saving goal")
        }
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}
