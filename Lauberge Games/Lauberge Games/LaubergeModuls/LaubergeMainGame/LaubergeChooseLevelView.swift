import SwiftUI

struct LaubergeChooseLevelView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: LaubergeShopViewModel
    
    @State var openGame = false
    @State var selectedIndex = 0
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
                
                
                Spacer()
                
                VStack(spacing: 4) {
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0...9, id: \ .self) { index in
                            ZStack {
                                Image(.levelNumBgLauberge)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 150:100)
                                
                                Text("\(index + 1)")
                                    .font(.system(size: LaubergeDeviceManager.shared.deviceType == .pad ? 80:40, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .onTapGesture {
                                selectedIndex = index
                                DispatchQueue.main.async {
                                    openGame = true
                                }
                                
                            }
                        }
                    }.frame(width: LaubergeDeviceManager.shared.deviceType == .pad ? 500:340)
            
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
        .fullScreenCover(isPresented: $openGame) {
             LaubergeGameView(shopVM: shopVM, level: selectedIndex)
        }
    }
    
}


#Preview {
    LaubergeChooseLevelView(shopVM: LaubergeShopViewModel())
}
