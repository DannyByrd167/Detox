//
//  WhatsYourScreenTimeView.swift
//  Detox
//
//  Created by Danny Byrd on 1/24/25.
//

import SwiftUI

struct WhatsYourScreenTimeView: View {
    @Binding var currentScreenTime: Int?
    
    var body: some View {
        VStack {
            Text("What's Your Current Screen Time?")
                .customTextStyle(size: 32)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Button {
                currentScreenTime = 0
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 70)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(currentScreenTime == 0 ? .white : .clear, lineWidth: 5)
                            
                            Text("<2 Hours")
                                .customTextStyle(size: 32)
                        }
                    }
            }
            
            Button {
                currentScreenTime = 2
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 70)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(currentScreenTime == 2 ? .white : .clear, lineWidth: 5)
                            
                            Text("2-4 Hours")
                                .customTextStyle(size: 32)
                        }
                    }
            }
            
            Button {
                currentScreenTime = 4
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 70)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(currentScreenTime == 4 ? .white : .clear, lineWidth: 5)
                            
                            Text("4-6 Hours")
                                .customTextStyle(size: 32)
                        }
                    }
            }
            
            Button {
                currentScreenTime = 6
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 70)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(currentScreenTime == 6 ? .white : .clear, lineWidth: 5)
                            
                            Text("6-8 Hours")
                                .customTextStyle(size: 32)
                        }
                    }
            }
            
            Button {
                currentScreenTime = 8
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                    .frame(height: 70)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(currentScreenTime == 8 ? .white : .clear, lineWidth: 5)
                            
                            Text("8+ Hours")
                                .customTextStyle(size: 32)
                        }
                    }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    WhatsYourScreenTimeView(currentScreenTime: .constant(nil))
}
