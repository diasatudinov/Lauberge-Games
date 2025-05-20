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
                            Image(.backIconArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        Spacer()
                        
                        ArgosyCoinBg()
                    }.padding([.horizontal, .top])
                    
                }
                Image(.miniGameTextArgosy)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                Spacer()
                
                VStack(spacing: 13) {
                    Button {
                        game1 = true
                    } label: {
                        Image(.gameText1Argosy)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game2 = true
                    } label: {
                        Image(.gameText2Argosy)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game3 = true
                    } label: {
                        Image(.gameText3Argosy)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game4 = true
                    } label: {
                        Image(.gameText4Argosy)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                }
                
                Spacer()
                
            }
        }.background(
            ZStack {
                Image(.appBgArgosy)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $game1) {
            ArgosyNumberGuessGame()
        }
        .fullScreenCover(isPresented: $game2) {
            ArgosyCoupleGameView()
        }
        .fullScreenCover(isPresented: $game3) {
            ArgosyMemorizationView()
        }
        .fullScreenCover(isPresented: $game4) {
            ArgosyMazeGameView()
        }
    }
}

#Preview {
    ArgosyChooseMiniGame()
}
