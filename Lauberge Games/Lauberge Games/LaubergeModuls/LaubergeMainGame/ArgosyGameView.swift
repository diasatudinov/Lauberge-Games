import SwiftUI
import SpriteKit

struct ArgosyGameView: View {
    @Environment(\.presentationMode) var presentationMode
   
    @State var gameScene: ArgosyGameScene = {
        let scene = ArgosyGameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    @ObservedObject var shopVM: ArgosyShopViewModel
    @State private var powerUse = false
    @State private var isWin = false
    @State private var score = 0
    @State var level: Int
    
    var imagesForView: [String] = ["viewImage1","viewImage2","viewImage3","viewImage4"]
    
    var body: some View {
        ZStack {
            ArgosySpriteViewContainer(scene: gameScene, isWin: $isWin, score: $score, level: level)
                .ignoresSafeArea()
            
            VStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? 200:100) {
                HStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? 200:100) {
                    ZStack {
                        Image(.rectangleMainGameLauberge1)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 280:140,height: ArgosyDeviceManager.shared.deviceType == .pad ? 400:200)
                    
                    ZStack {
                        Image(.rectangleMainGameLauberge2)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 280:140,height: ArgosyDeviceManager.shared.deviceType == .pad ? 400:200)
                }
                
                HStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? 200:100) {
                    ZStack {
                        Image(.rectangleMainGameLauberge3)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 280: 140,height: ArgosyDeviceManager.shared.deviceType == .pad ? 400:200)
                    
                    ZStack {
                        Image(.rectangleMainGameLauberge4)
                            .resizable()
                            .scaledToFit()
                            
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                    }
                    .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 280:140,height: ArgosyDeviceManager.shared.deviceType == .pad ? 400:200)
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
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
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
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 400:223)
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(.nextLvlBtnLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 200:105)
                        }
                        
                        Button {
                            gameScene.restartLevel()
                            isWin = false
                        } label: {
                            Image(.restartBtnLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 200:105)
                        }
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(.backBtnLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 200:105)
                        }
                        
                    }.padding(.bottom, ArgosyDeviceManager.shared.deviceType == .pad ? 100 : 50)
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
    ArgosyGameView(shopVM: ArgosyShopViewModel(), level: 0)
}
