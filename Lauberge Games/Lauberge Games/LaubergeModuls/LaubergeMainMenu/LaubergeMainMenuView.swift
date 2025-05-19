//
//  LaubergeMainMenuView.swift
//  Lauberge Games
//
//  Created by Dias Atudinov on 19.05.2025.
//

import SwiftUI

struct LaubergeMainMenuView: View {
    @State private var showGame = false
    @State private var showShop = false
    @State private var showAchievement = false
    @State private var showMiniGames = false
    @State private var showSettings = false
    
//    @StateObject var achievementVM = ArgosyAchievementsViewModel()
//    @StateObject var settingsVM = ArgosySettingsViewModel()
//    @StateObject var shopVM = ArgosyShopViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 15) {
                HStack(alignment: .top) {
                    
                    
                    Spacer()
                    
                    ArgosyCoinBg()
                    
                    
                }
                
                Spacer()
                
                Button {
                    showGame = true
                } label: {
                    Image(.playIconArgosy)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                }
                
                Button {
                    showShop = true
                } label: {
                    Image(.shopIconArgosy)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                }
                
                Button {
                    showAchievement = true
                } label: {
                    Image(.achievementsIconArgosy)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                }
                
                Button {
                    showSettings = true
                } label: {
                    Image(.settingsIconArgosy)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                }
                
                
                Button {
                    showMiniGames = true
                } label: {
                    Image(.miniGamesIconArgosy)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 160:80)
                }
                
                Spacer()
                
            }.padding()
            
        }
        .background(
            ZStack {
                Image(.appBgArgosy)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $showGame) {
//            ArgosyChooseLevelView(shopVM: shopVM)
        }
        .fullScreenCover(isPresented: $showMiniGames) {
//            ArgosyChooseMiniGame()
        }
        .fullScreenCover(isPresented: $showAchievement) {
//            ArgosyAchievementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showShop) {
//            ArgosyShopView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
//            ArgosySettingsView(settingsVM: settingsVM)
        }
        
    }
    
}


#Preview {
    LaubergeMainMenuView()
}
