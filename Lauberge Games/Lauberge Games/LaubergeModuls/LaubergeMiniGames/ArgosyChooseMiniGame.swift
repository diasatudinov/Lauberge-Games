//
//  ArgosyChooseMiniGame.swift
//  Lauberge Games
//
//  Created by Dias Atudinov on 20.05.2025.
//


import SwiftUI

struct ArgosyChooseMiniGame: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var game1 = false
    @State private var game2 = false
    @State private var game3 = false
    @State private var game4 = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        Spacer()
                        
                        ArgosyCoinBg()
                    }.padding([.horizontal, .top])
                    
                }
                
                Image(.miniGameTextLauberge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 136:68)
                Spacer()
                
                VStack(spacing: 13) {
                    Button {
                        game1 = true
                    } label: {
                        Image(.guessTheNumTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game2 = true
                    } label: {
                        Image(.matchCardTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game3 = true
                    } label: {
                        Image(.simonSaysTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game4 = true
                    } label: {
                        Image(.mazeTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                }
                
                Spacer()
                
            }
        }.background(
            ZStack {
                Image(.appBgLauberge)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $game1) {
//            ArgosyNumberGuessGame()
        }
        .fullScreenCover(isPresented: $game2) {
//            ArgosyCoupleGameView()
        }
        .fullScreenCover(isPresented: $game3) {
//            ArgosyMemorizationView()
        }
        .fullScreenCover(isPresented: $game4) {
//            ArgosyMazeGameView()
        }
    }
}

#Preview {
    ArgosyChooseMiniGame()
}
