//
//  LaubergeLoaderView.swift
//  Lauberge Games
//
//  Created by Dias Atudinov on 19.05.2025.
//

import SwiftUI

struct LaubergeLoaderView: View {
    @State private var scale: CGFloat = 1.0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    var body: some View {
        ZStack {
            Image(.loadingViewBgLauberge)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
              
                
                
                Spacer()
                
                Image(.loadingTextLauberge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 39)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: scale
                    )
                    .onAppear {
                        scale = 0.8
                    }
                    .padding(.bottom, 15)
                
                ZStack {
                   
                    Image(.loaderLauberge)
                        .resizable()
                        .scaledToFit()
                        .colorMultiply(.gray)
                    
                    Image(.loaderLauberge)
                        .resizable()
                        .scaledToFit()
                        .mask(
                            Rectangle()
                                .frame(width: progress * 350)
                                .padding(.trailing, (1 - progress) * 350)
                        )
                    
                }
                .frame(width: 350)
            }
            
            
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 1 {
                progress += 0.01
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    LaubergeLoaderView()
}
