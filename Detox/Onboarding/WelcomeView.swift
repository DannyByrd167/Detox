//
//  WelcomeView.swift
//  Detox
//
//  Created by Danny Byrd on 3/18/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Disconnect!")
                .customTextStyle(size: 30)
            
            Spacer()
            
            Text("Disconnect from your phone...")
                .customTextStyle(size: 20)
            
            Text("Reconnect with the world!")
                .customTextStyle(size: 20)
            Spacer()
        }
    }
}
