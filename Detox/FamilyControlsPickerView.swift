//
//  FamilyControlsPickerView.swift
//  Detox
//
//  Created by Danny Byrd on 12/30/24.
//

import SwiftUI
import FamilyControls

struct FamilyControlsPickerView: View {
    @Binding var selectionToRestrict: FamilyActivitySelection
    @State var isShowingError = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.949, green: 0.949, blue: 0.945)
                    .ignoresSafeArea()
                FamilyActivityPicker(headerText: "Pick <30 apps to include in this detox",selection: $selectionToRestrict)
                    .onChange(of: selectionToRestrict) { _, newValue in
                        ScreenTimeManager.selectionToRestrict = newValue
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                if selectionToRestrict.applications.isEmpty {
                                    isShowingError.toggle()
                                } else {
                                    dismiss()
                                }
                            } label: {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    .alert("Please Select At Least One App", isPresented: $isShowingError) { }
            }
        }
    }
}

#Preview {
    FamilyControlsPickerView(selectionToRestrict: .constant(.init(includeEntireCategory: true)))
}
