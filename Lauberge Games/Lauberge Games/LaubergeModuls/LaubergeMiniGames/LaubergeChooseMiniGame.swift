import SwiftUI

struct LaubergeChooseMiniGame: View {
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
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        Spacer()
                        
                        LaubergeCoinBg()
                    }.padding([.horizontal, .top])
                    
                }
                
                Image(.miniGameTextLauberge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 136:68)
                Spacer()
                
                VStack(spacing: 13) {
                    Button {
                        game1 = true
                    } label: {
                        Image(.guessTheNumTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game2 = true
                    } label: {
                        Image(.matchCardTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game3 = true
                    } label: {
                        Image(.simonSaysTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game4 = true
                    } label: {
                        Image(.mazeTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 180:90)
                          
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
            LaubergeNumberGuessGame()
        }
        .fullScreenCover(isPresented: $game2) {
            LaubergeCoupleGameView()
        }
        .fullScreenCover(isPresented: $game3) {
            LaubergeMemorizationView()
        }
        .fullScreenCover(isPresented: $game4) {
            LaubergeMazeGameView()
        }
    }
}

#Preview {
    LaubergeChooseMiniGame()
}
