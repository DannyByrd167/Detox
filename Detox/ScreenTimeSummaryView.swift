//
//  ScreenTimeSummaryView.swift
//  Detox
//
//  Created by Danny Byrd on 12/29/24.
//

import SwiftUI
import DeviceActivity

struct ScreenTimeSummaryView: View {
    @State private var context: DeviceActivityReport.Context = .totalActivity
    
    @State private var filter = DeviceActivityFilter(
        segment: .daily(during: DateInterval(start: Calendar.current.startOfDay(for: .now), end: .now)),
        users: .all,
        devices: .init([.iPhone])
    )
    
    var body: some View {
        DeviceActivityReport(context, filter: filter)
    }
}

#Preview {
    ScreenTimeSummaryView()
}
