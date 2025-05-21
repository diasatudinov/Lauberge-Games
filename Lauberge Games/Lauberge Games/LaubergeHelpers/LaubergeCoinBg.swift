import SwiftUI

struct LaubergeCoinBg: View {
    @StateObject var user = LaubergeUser.shared
    var body: some View {
        ZStack {
            Image(.coinsBgLauberge)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: LaubergeDeviceManager.shared.deviceType == .pad ? 48:24, weight: .black))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .offset(x: 12, y: -3)
            
            
            
        }.frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 100:50)
        
    }
}

#Preview {
    LaubergeCoinBg()
}
