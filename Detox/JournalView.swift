//
//  JournalView.swift
//  Detox
//
//  Created by Danny Byrd on 3/15/25.
//

import SwiftUI

struct UISliderView: UIViewRepresentable {
    @Binding var value: Double
    
    var minValue = 1.0
    var maxValue = 100.0
    var thumbColor: UIColor = .white
    var minTrackColor: UIColor = .blue
    var maxTrackColor: UIColor = .lightGray
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    func makeCoordinator() -> UISliderView.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}

enum Feeling: String, CaseIterable, Codable {
    case happy = "😁"
    case cool = "😎"
    case neutral = "😐"
    case anxious = "😰"
    case excited = "🤩"
    case angry = "😠"
    case tired = "😴"
    case sad = "😔"
    
    static func allCases() -> [Feeling] {
        return [
            .happy,
            .cool,
            .neutral,
            .anxious,
            .excited,
            .angry,
            .tired,
            .sad
        ]
    }
}


struct JournalView: View {
    @Environment(\.dismiss) var dismiss
    @State var vm: JournalViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(#colorLiteral(red: 0.216, green: 0.235, blue: 0.518, alpha: 1)) // #373c84
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        VStack {
                            Text("Detox difficulty today:")
                                .customTextStyle(size: 30)
                            
                            Text("0: Easy, 10: Difficult")
                                .foregroundStyle(.white.opacity(0.6))
                                .font(.system(size: 20, weight: .regular, design: .default))
                            
                            HStack {
                                Text("0")
                                    .customTextStyle(size: 25)
                                
                                UISliderView(value: $vm.difficulty, minValue: 0, maxValue: 10, thumbColor: .white, minTrackColor: .red, maxTrackColor: .green)
                                
                                Text("10")
                                    .customTextStyle(size: 25)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                        )
                        .padding(.horizontal)
                        
                        VStack {
                            Text("How are you feeling?")
                                .customTextStyle(size: 30)
                                .padding(.top)
                            
                            LazyHGrid(rows: [.init(.fixed(90)), .init(.fixed(90))], spacing: 5) {
                                ForEach(Feeling.allCases(), id: \.rawValue) { feeling in
                                    Button {
                                        vm.feeling = feeling
                                    } label: {
                                        Text(feeling.rawValue)
                                            .font(.system(size: 70))
                                            .padding(.horizontal, 5)
                                            .background (
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(Color(#colorLiteral(red: 0.216, green: 0.235, blue: 0.518, alpha: 1)).opacity(0.5))
                                                    .stroke(vm.feeling == feeling ? .white : .clear)
                                            )
                                    }
                                }
                            }
                        }
                        .padding()
                        .background (
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                        )
                        .padding(.horizontal)
                        
                        Text("How is your detox going?")
                            .customTextStyle(size: 30)
                            .padding(.top, 15)
                        
                        TextField(
                            text: $vm.response,
                            prompt: Text("Enter your response here").foregroundStyle(.white.opacity(0.6)).bold().font(.system(size: 20)),
                            axis: .vertical
                        ) { }
                            .foregroundStyle(.white).bold().font(.system(size: 20))
                            .padding()
                            .background (
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)))
                            )
                            .padding(.horizontal)
                        
                        
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(.white)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Journal")
                        .customTextStyle(size: 25)
                }
            }
            .toolbarBackground(Color(#colorLiteral(red: 0.365, green: 0.38, blue: 0.608, alpha: 1)), for: .navigationBar)
        }
    }
}

#Preview {
    JournalView(vm: .init())
}
