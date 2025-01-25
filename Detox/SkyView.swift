//
//  SkyView.swift
//  Detox
//
//  Created by Danny Byrd on 12/31/24.
//

import SwiftUI

struct SkyView: View {
    @State private var cloud1Offset: CGFloat = -UIScreen.main.bounds.width
    @State private var cloud2Offset: CGFloat =  -UIScreen.main.bounds.width
    @State private var cloud3Offset: CGFloat =  -UIScreen.main.bounds.width
    @State private var cloud4Offset: CGFloat =  -UIScreen.main.bounds.width
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)),
                        Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                
                Image("Cloud1")
                    .position(y: proxy.size.height - .random(in: 0...proxy.size.height / 2))
                    .offset(x: cloud1Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud1Offset)
                Image("Cloud2")
                    .position(y: proxy.size.height - .random(in: 50...100))
                    .offset(x: cloud2Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud2Offset)
                Image("Cloud3")
                    .position(y: proxy.size.height - .random(in: 50...100))
                    .offset(x: cloud3Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud3Offset)
                Image("Cloud4")
                    .position(y: proxy.size.height - .random(in: 50...100))
                    .offset(x: cloud4Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud4Offset)
                Image("Cloud1")
                    .position(y: proxy.size.height - .random(in: 0...proxy.size.height / 2))
                    .offset(x: cloud1Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud1Offset)
                Image("Cloud2")
                    .position(y: proxy.size.height - .random(in: 50...100))
                    .offset(x: cloud2Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud2Offset)
                Image("Cloud3")
                    .position(y: proxy.size.height - .random(in: 50...100))
                    .offset(x: cloud3Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud3Offset)
                Image("Cloud4")
                    .position(y: proxy.size.height - .random(in: 50...100))
                    .offset(x: cloud4Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud4Offset)
                
                
                
                Image("Cloud1")
                    .position(y: proxy.size.height - .random(in: proxy.size.height / 2 ... proxy.size.height))
                    .offset(x: cloud1Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud1Offset)
                Image("Cloud2")
                    .position(y: proxy.size.height - .random(in: proxy.size.height / 2 ... proxy.size.height))
                    .offset(x: cloud2Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud2Offset)
                Image("Cloud3")
                    .position(y: proxy.size.height - .random(in: proxy.size.height / 2 ... proxy.size.height))
                    .offset(x: cloud3Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud3Offset)
                Image("Cloud4")
                    .position(y: proxy.size.height - .random(in: proxy.size.height / 2 ... proxy.size.height))
                    .offset(x: cloud4Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud4Offset)
                Image("Cloud1")
                    .position(y: proxy.size.height - .random(in: proxy.size.height / 2 ... proxy.size.height))
                    .offset(x: cloud1Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud1Offset)
                Image("Cloud2")
                    .position(y: proxy.size.height - .random(in: proxy.size.height / 2 ... proxy.size.height))
                    .offset(x: cloud2Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud2Offset)
                Image("Cloud3")
                    .position(y: proxy.size.height - .random(in: proxy.size.height / 2 ... proxy.size.height))
                    .offset(x: cloud3Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud3Offset)
                Image("Cloud4")
                    .position(y: proxy.size.height - .random(in: proxy.size.height / 2 ... proxy.size.height))
                    .offset(x: cloud4Offset)
                    .animation(Animation.linear(duration: .random(in: 20...35)).repeatForever(autoreverses: false), value: cloud4Offset)
                
                
            }
            .onAppear {
                animateClouds()
            }
        }
    }
    
    func animateClouds() {
        withAnimation {
            cloud1Offset = UIScreen.main.bounds.width * 1.5
            cloud2Offset = UIScreen.main.bounds.width * 1.5
            cloud3Offset = UIScreen.main.bounds.width * 1.5
            cloud4Offset = UIScreen.main.bounds.width * 1.5
            
        }
        
        
    }
}

#Preview {
    SkyView()
}
