import SwiftUI
import SpriteKit

struct LaubergeMazeGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isWin = false
    @State private var gameScene: ArgosyMazeScene = {
        let scene = ArgosyMazeScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    @State private var powerUse = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                Image(.mazeGameTextLauberge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 210:105)
                
                Image(.guessNumGameBgLauberge)
                    .resizable()
                    .scaledToFit()
            }
            ArgosyMazeViewContainer(scene: gameScene, isWin: $isWin)
                
            
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

                    }.padding([.horizontal])
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Button {
                        gameScene.moveUp()
                        
                    } label: {
                        Image(.controlArrowLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 100:50)
                    }
                    HStack(spacing: LaubergeDeviceManager.shared.deviceType == .pad ? 100:50) {
                        Button {
                            gameScene.moveLeft()
                        } label: {
                            Image(.controlArrowLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 100:50)
                                .rotationEffect(.degrees(90))
                                .scaleEffect(x: -1, y: 1)
                        }
                        
                        Button {
                            gameScene.moveRight()
                        } label: {
                            Image(.controlArrowLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 100:50)
                                .rotationEffect(.degrees(90))
                        }
                    }
                    
                    Button {
                        gameScene.moveDown()
                    } label: {
                        Image(.controlArrowLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 100:50)
                            .scaleEffect(x: 1, y: -1)
                    }
                }.padding(.bottom, 50)
                
                
            }
            
            if isWin {
                ZStack {
                    
                    Color.black.opacity(0.5).ignoresSafeArea()
                    VStack {
                        
                        Image(.winBgLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 400:223)
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(.nextLvlBtnLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 200:105)
                        }
                        
                        Button {
                            gameScene.restartGame()
                            isWin = false
                        } label: {
                            Image(.restartBtnLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 200:105)
                        }
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(.backBtnLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 200:105)
                        }
                        
                    }.padding(.bottom, LaubergeDeviceManager.shared.deviceType == .pad ? 100 : 50)
                }
                 
            }
            
        }.background(
            ZStack {
                Image(.appBgLauberge)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
}

#Preview {
    LaubergeMazeGameView()
}
