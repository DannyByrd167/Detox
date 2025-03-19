//
//  StartDetoxView.swift
//  Detox
//
//  Created by Danny Byrd on 3/15/25.
//

import SwiftUI
import FamilyControls

struct StartDetoxView: View {
    let detoxLengths: [DetoxType] = [.day, .week, .month]
    
    @State var detoxLength: DetoxType?
    @State var selectedApps: FamilyActivitySelection = .init(includeEntireCategory: true)
    @State var isShowingFamilyControlsPicker = false
    @State var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.216, green: 0.235, blue: 0.518, alpha: 1)) // #373c84
                .ignoresSafeArea()
            
            VStack {
                Text("Start a Detox")
                    .customTextStyle(size: 40)
                
                VStack {
                    HStack {
                        Text("Pick your apps:")
                            .customTextStyle(size: 24)
                        
                        Spacer()
                        
                        Button {
                            isShowingFamilyControlsPicker.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 40) {
                            ForEach(Array(selectedApps.applicationTokens), id: \.self) { app in
                                Label(app).labelStyle(.iconOnly)
                                    .scaleEffect(3)
                            }
                            
                            ForEach(0..<6, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.clear)
                                    .stroke(.white, lineWidth: 3)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.never)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                )
                .padding()
                
                VStack {
                    HStack {
                        Text("Pick your length:")
                            .customTextStyle(size: 24)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack {
                        ForEach(detoxLengths, id: \.rawValue) { length in
                            Button {
                                withAnimation {
                                    detoxLength = length
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                                    .opacity(0.5)
                                    .overlay {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(length == detoxLength ? .white : .clear, lineWidth: 5)
                                            
                                            Text(length.rawValue)
                                                .customTextStyle(size: 32)
                                        }
                                    }
                                    .frame(height: 80)
                                
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                )
                .padding()
                
                Spacer()
                
                Button {
                    guard let detoxLength else {
                        print("No detox length")
                        return
                    }
                    onboardingViewModel.saveOnboardingData(startDate: .now, detoxType: detoxLength, screenTimeEstimate: onboardingViewModel.screenTimeEstimate ?? 0, screenTimeGoal: onboardingViewModel.screenTimeGoal)
                    ScreenTimeManager.startDetox(type: detoxLength)
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(selectedApps.applicationTokens.isEmpty || detoxLength == nil ? .gray.opacity(0.5) : Color(#colorLiteral(red: 0.525, green: 0.431, blue: 0.898, alpha: 1)))
                        .overlay {
                            Text("Start your Detox")
                                .foregroundColor(selectedApps.applicationTokens.isEmpty || detoxLength == nil ? .gray : .white)
                                .font(.system(size: 32, weight: .bold, design: .default))
                        }
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .padding(.horizontal)
                }
                .disabled(selectedApps.applicationTokens.isEmpty || detoxLength == nil)
                
            }
        }
        .fullScreenCover(isPresented: $isShowingFamilyControlsPicker) {
            FamilyControlsPickerView(selectionToRestrict: $selectedApps)
        }
    }
}

#Preview {
    StartDetoxView(onboardingViewModel: .init())
}
