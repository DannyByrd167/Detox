//
//  DetoxTimerView.swift
//  Detox
//
//  Created by Danny Byrd on 12/31/24.
//

import SwiftUI

struct DetoxTimerView: View {
    @State var elapsedTimeSeconds: Int
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        Text(timeFormatted())
            .customTextStyle(size: 25)
            .contentTransition(.numericText())
            .onReceive(timer) { _ in
                withAnimation {
                    elapsedTimeSeconds += 1
                }
            }
    }
    
    func timeFormatted() -> String {
        "\((elapsedTimeSeconds / 36000))\((elapsedTimeSeconds / 3600) % 10):"
        + "\((elapsedTimeSeconds / 600) % 10)\((elapsedTimeSeconds / 60) % 10):"
        + "\((elapsedTimeSeconds / 10) % 6)\(elapsedTimeSeconds % 10)"
    }
}

#Preview {
    DetoxTimerView(elapsedTimeSeconds: 0)
}
