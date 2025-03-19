//
//  Tip.swift
//  Detox
//
//  Created by Danny Byrd on 3/15/25.
//

import Foundation

struct Tip {
    static let tips: [String] = [
        "Start your day without your phone—avoid screens for the first 30 minutes",
        "Keep your phone out of sight when focusing or relaxing",
        "Delay the urge—wait 5 minutes before opening an app",
        "Set your screen to grayscale to make apps less stimulating",
        "Have a go-to offline activity ready for boredom",
        "Avoid screens at least an hour before bed",
        "Use social media only on a computer",
        "Turn off all non-essential notifications",
        "Use a physical alarm clock instead of your phone",
    ]
    
    static func randomTip() -> String {
        guard let tip = tips.randomElement() else {
            return "Keep your phone out of sight when focusing or relaxing"
        }
        
        return tip
    }
}
