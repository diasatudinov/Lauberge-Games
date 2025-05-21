import SwiftUI
import SpriteKit

struct LaubergeGameView: View {
    @Environment(\.presentationMode) var presentationMode
   
    @State var gameScene: LaubergeGameScene = {
        let scene = LaubergeGameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    @ObservedObject var shopVM: LaubergeShopViewModel
    @State private var powerUse = false
    @State private var isWin = false
    @State private var score = 0
    @State var level: Int
    
    var imagesForView: [String] = ["viewImage1","viewImage2","viewImage3","viewImage4"]
    
    var body: some View {
        ZStack {
            LaubergeSpriteViewContainer(scene: gameScene, isWin: $isWin, score: $score, level: level)
                .ignoresSafeArea()
            
            VStack(spacing: LaubergeDeviceManager.shared.deviceType == .pad ? 200:100) {
                HStack(spacing: LaubergeDeviceManager.shared.deviceType == .pad ? 200:100) {
                    ZStack {
                        Image(.rectangleMainGameLauberge1)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    .frame(width: LaubergeDeviceManager.shared.deviceType == .pad ? 280:140,height: LaubergeDeviceManager.shared.deviceType == .pad ? 400:200)
                    
                    ZStack {
                        Image(.rectangleMainGameLauberge2)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: LaubergeDeviceManager.shared.deviceType == .pad ? 280:140,height: LaubergeDeviceManager.shared.deviceType == .pad ? 400:200)
                }
                
                HStack(spacing: LaubergeDeviceManager.shared.deviceType == .pad ? 200:100) {
                    ZStack {
                        Image(.rectangleMainGameLauberge3)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: LaubergeDeviceManager.shared.deviceType == .pad ? 280: 140,height: LaubergeDeviceManager.shared.deviceType == .pad ? 400:200)
                    
                    ZStack {
                        Image(.rectangleMainGameLauberge4)
                            .resizable()
                            .scaledToFit()
                            
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                    }
                    .frame(width: LaubergeDeviceManager.shared.deviceType == .pad ? 280:140,height: LaubergeDeviceManager.shared.deviceType == .pad ? 400:200)
                }
            }
            
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
                        
                    }.padding([.horizontal, .top])
                }
                
                Spacer()
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
                            gameScene.restartLevel()
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
                Image(.gameMainBgLauberge)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                
            }
        )
    }
}

#Preview {
    LaubergeGameView(shopVM: LaubergeShopViewModel(), level: 0)
}
