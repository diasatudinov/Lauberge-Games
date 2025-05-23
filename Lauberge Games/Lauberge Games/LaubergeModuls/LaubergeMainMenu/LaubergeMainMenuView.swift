import SwiftUI

struct LaubergeMainMenuView: View {
    @State private var showGame = false
    @State private var showShop = false
    @State private var showAchievement = false
    @State private var showMiniGames = false
    @State private var showSettings = false
    
    @StateObject var achievementVM = LaubergeAchievementsViewModel()
    @StateObject var settingsVM = LaubergeSettingsViewModel()
    @StateObject var shopVM = LaubergeShopViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 15) {
                HStack(alignment: .top) {
                    
                    
                    Spacer()
                    
                    LaubergeCoinBg()
                    
                    
                }
                
                Spacer()
                
                Button {
                    showGame = true
                } label: {
                    Image(.playIconLauberge)
                        .resizable()
                        .scaledToFit()
                        .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 188:94)
                }
                
                Button {
                    showShop = true
                } label: {
                    Image(.shopIconLauberge)
                        .resizable()
                        .scaledToFit()
                        .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 188:94)
                }
                
                Button {
                    showAchievement = true
                } label: {
                    Image(.achievementIconLauberge)
                        .resizable()
                        .scaledToFit()
                        .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 188:94)
                }
                HStack {
                    
                    Button {
                        showMiniGames = true
                    } label: {
                        Image(.miniGameIconLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 134:67)
                    }
                    
                    Button {
                        showSettings = true
                    } label: {
                        Image(.settingsIconLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 134:67)
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
            LaubergeChooseLevelView(shopVM: shopVM)
        }
        .fullScreenCover(isPresented: $showMiniGames) {
            LaubergeChooseMiniGame()
        }
        .fullScreenCover(isPresented: $showAchievement) {
            LaubergeAchievementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showShop) {
            LaubergeShopView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
            LaubergeSettingsView(settingsVM: settingsVM)
        }
        
    }
    
}


#Preview {
    LaubergeMainMenuView()
}
