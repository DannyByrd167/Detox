//
//  ShieldConfigurationExtension.swift
//  CustomShieldExtension
//
//  Created by Danny Byrd on 12/27/24.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        let config = ShieldConfiguration(
            backgroundBlurStyle: .light,
            backgroundColor: UIColor(.indigo.mix(with: .cyan, by: 0.5)),
            icon: UIImage(named: "iPhoneX"),
            title: .init(text: "Detoxing...", color: .black),
            subtitle: .init(text: "", color: .clear),
            primaryButtonLabel: .init(text: "", color: .clear),
            primaryButtonBackgroundColor: .clear
        )
        
        return config
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        let config = ShieldConfiguration(
            backgroundBlurStyle: .dark,
            backgroundColor: .black,
            icon: .checkmark,
            title: .init(text: "title", color: .black),
            subtitle: .init(text: "subtitle", color: .black),
            primaryButtonLabel: .init(text: "primaryButtonLabel", color: .black),
            primaryButtonBackgroundColor: .black,
            secondaryButtonLabel: nil
        )
        
        return config
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}
