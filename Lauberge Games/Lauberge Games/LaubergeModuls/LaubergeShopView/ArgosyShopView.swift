import SwiftUI


struct ArgosyShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = ArgosyUser.shared
    @State var section: ArgosyStoreSection = .skin
    @ObservedObject var viewModel: ArgosyShopViewModel
    @State var skinIndex: Int = 0
    @State var backIndex: Int = 0
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    
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
                            
                        }.padding([.horizontal])
                    }
                }
                
                Image(.shopTextArgosy)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 150:75)
                
                Spacer()
                ZStack {
                    Image(.skinBgArgosy)
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        Button {
                            if skinIndex > 0 {
                                skinIndex -= 1
                            }
                        } label: {
                            Image(.arrowShopArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                                .scaleEffect(x: -1,y: 1)
                        }
                        Spacer()
                        
                        achievementItem(item: viewModel.shopTeamItems.filter({ $0.section == .skin })[skinIndex])
                        
                        Spacer()
                        
                        Button {
                            if skinIndex < viewModel.shopTeamItems.filter({ $0.section == .skin }).count - 1 {
                                skinIndex += 1
                            }
                        } label: {
                            Image(.arrowShopArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                            
                        }
                    }.offset(y: 40)
                }.frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 500:250, height: ArgosyDeviceManager.shared.deviceType == .pad ? 450:250)
                
                ZStack {
                    Image(.backBgArgosy)
                        .resizable()
                        .scaledToFit()
                    
                    HStack(spacing: 40) {
                        Button {
                            if backIndex > 0 {
                                backIndex -= 1
                            }
                        } label: {
                            Image(.arrowShopArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                                .scaleEffect(x: -1,y: 1)
                        }
                        
                      
                        
                        achievementItem(item: viewModel.shopTeamItems.filter({ $0.section == .backgrounds })[backIndex])
                        
                     
                        
                        Button {
                            if backIndex < viewModel.shopTeamItems.filter({ $0.section == .backgrounds }).count - 1 {
                                backIndex += 1
                            }
                        } label: {
                            Image(.arrowShopArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                    }.offset(y: ArgosyDeviceManager.shared.deviceType == .pad ? 50:40)
                    
                }.frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 500:250, height: ArgosyDeviceManager.shared.deviceType == .pad ? 450:250)
                
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
    }
    
    @ViewBuilder func achievementItem(item: Item) -> some View {
        
        
        VStack {
            Image(item.icon)
                .resizable()
                .scaledToFit()
                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 250:120)
            
            if item.section == .skin {
                if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                    VStack {
                        Spacer()
                        ZStack {
                            
                            if let currentItem = viewModel.currentPersonItem, currentItem.name == item.name {
                                Image(.arrowShopArgosy)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                                    .rotationEffect(.degrees(90))
                            }
                            
                        }
                    }
                } else {
                    VStack {
                        ZStack {
                            Image(.priceArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                            
                            
                        }
                    }
                }
            } else {
                if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                    VStack {
                        Spacer()
                        ZStack {
                            
                            if let currentItem = viewModel.currentBgItem, currentItem.name == item.name {
                                Image(.arrowShopArgosy)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                                    .rotationEffect(.degrees(90))
                            }
                            
                        }
                    }
                } else {
                    VStack {
                        ZStack {
                            Image(.priceArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                            
                            
                        }
                    }
                }
            }
            
        }.frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 314:150)
            .onTapGesture {
                if item.section == .skin {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        viewModel.currentPersonItem = item
                    } else {
                        if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            
                            if user.money >= item.price {
                                user.minusUserMoney(for: item.price)
                                viewModel.boughtItems.append(item)
                            }
                        }
                    }
                } else {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        viewModel.currentBgItem = item
                    } else {
                        if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            
                            if user.money >= item.price {
                                user.minusUserMoney(for: item.price)
                                viewModel.boughtItems.append(item)
                            }
                        }
                    }
                }
            }
        
        
    }
    
}


#Preview {
    ArgosyShopView(viewModel: ArgosyShopViewModel())
}
