import SwiftUI

struct LaubergeMainMenuView: View {
    @State private var showGame = false
    @State private var showShop = false
    @State private var showAchievement = false
    @State private var showMiniGames = false
    @State private var showSettings = false
    
    @StateObject var achievementVM = ArgosyAchievementsViewModel()
    @StateObject var settingsVM = ArgosySettingsViewModel()
    @StateObject var shopVM = ArgosyShopViewModel()
    
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
                    Image(.playIconLauberge)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 188:94)
                }
                
                Button {
                    showShop = true
                } label: {
                    Image(.shopIconLauberge)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 188:94)
                }
                
                Button {
                    showAchievement = true
                } label: {
                    Image(.achievementIconLauberge)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 188:94)
                }
                HStack {
                    Button {
                        showSettings = true
                    } label: {
                        Image(.settingsIconLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 134:67)
                    }
                    
                    
                    Button {
                        showMiniGames = true
                    } label: {
                        Image(.miniGameIconLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 134:67)
                    }
                }
                Spacer()
                
            }.padding()
            
        }
        .background(
            ZStack {
                Image(.appBgLauberge)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $showGame) {
            ArgosyChooseLevelView(shopVM: shopVM)
        }
        .fullScreenCover(isPresented: $showMiniGames) {
//            ArgosyChooseMiniGame()
        }
        .fullScreenCover(isPresented: $showAchievement) {
            ArgosyAchievementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showShop) {
            ArgosyShopView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
            ArgosySettingsView(settingsVM: settingsVM)
        }
        
    }
    
}


#Preview {
    LaubergeMainMenuView()
}
