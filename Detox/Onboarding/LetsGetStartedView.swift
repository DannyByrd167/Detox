//
//  LetsGetStartedView.swift
//  Detox
//
//  Created by Danny Byrd on 1/24/25.
//

import SwiftUI
import FamilyControls

struct LetsGetStartedView: View {
    @State var activeButton = 1
    
    @Binding var selectedDetox: DetoxType?
    @Binding var restrictedAppsSelection: FamilyActivitySelection
    @Binding var isShowingStartButton: Bool
    
    @State var isShowingDetox = false
    
    
    var body: some View {
        VStack {
            Text("Let's Get Started!")
                .customTextStyle(size: 32)
            
            Button {
                Task {
                    await ScreenTimeManager.requestAuthorization()
                    withAnimation {
                        activeButton += 1
                    }
                }
            } label: {
                VStack {
                    if activeButton == 1 {
                        HStack {
                            Image(systemName: "arrow.down.forward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.down.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                    
                    HStack {
                        if activeButton > 1 {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundStyle(.green)
                        }
                        
                        Text("Connect To Screen Time")
                            .customTextStyle(size: activeButton == 1 ? 28 : 22)
                    }
                    .padding()
                    
                    if activeButton == 1 {
                        HStack {
                            Image(systemName: "arrow.up.forward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                )
                .padding(.horizontal)
            }
            .disabled(activeButton != 1)
            
            Button {
                isShowingDetox.toggle()
            } label: {
                VStack {
                    if activeButton == 2 {
                        HStack {
                            Image(systemName: "arrow.down.forward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.down.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                    
                    HStack {
                        if activeButton > 2 {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundStyle(.green)
                        }
                        
                        Text("Select Distracting Apps")
                            .customTextStyle(size: activeButton == 2 ? 28 : 22)
                    }
                    .padding()
                    
                    if activeButton == 2 {
                        HStack {
                            Image(systemName: "arrow.up.forward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                )
                .padding(.horizontal)
            }
            .disabled(activeButton != 2)
            
            
            VStack {
                Text("Pick Your Detox")
                    .customTextStyle(size: activeButton == 3 ? 28 : 22)
                    .padding()
                
                if activeButton == 3 {
                    Button {
                        selectedDetox = .day
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.5))
                                .frame(height: 120)
                                .overlay {
                                    ZStack {
                                        VStack {
                                            Text("24 Hour Detox")
                                                .customTextStyle(size: 28)
                                            
                                        }
                                        
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(selectedDetox == .day ? .white : .clear, lineWidth: 5)
                                    }
                                    
                                }
                                .padding(.horizontal)
                        }
                    }
                    
                    Button {
                        selectedDetox = .week
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.5))
                                .frame(height: 120)
                                .overlay {
                                    ZStack {
                                        VStack {
                                            Text("1 Week Detox")
                                                .customTextStyle(size: 28)
                                        }
                                        
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(selectedDetox == .week ? .white : .clear, lineWidth: 5)
                                    }
                                    
                                }
                                .padding(.horizontal)
                        }
                    }
                    
                    Button {
                        selectedDetox = .month
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)).opacity(0.5))
                                .frame(height: 120)
                                .overlay {
                                    ZStack {
                                        
                                        
                                        VStack {
                                            Text("1 Month Detox")
                                                .customTextStyle(size: 28)
                                            
                                        }
                                        
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(selectedDetox == .month ? .white : .clear, lineWidth: 5)
                                    }
                                    
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))

            )
            .padding(.horizontal)
        }
        .fullScreenCover(isPresented: $isShowingDetox) {
            withAnimation {
                isShowingStartButton.toggle()
                activeButton += 1
            }
        } content: {
            FamilyControlsPickerView(selectionToRestrict: $restrictedAppsSelection)
        }
    }
}

#Preview {
    LetsGetStartedView(selectedDetox: .constant(.none), restrictedAppsSelection: .constant(.init(includeEntireCategory: true)), isShowingStartButton: .constant(false))
}
