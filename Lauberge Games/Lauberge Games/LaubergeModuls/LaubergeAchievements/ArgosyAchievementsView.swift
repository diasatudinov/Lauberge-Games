import SwiftUI

struct ArgosyAchievementsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ArgosyAchievementsViewModel
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
                    }.padding([.horizontal, .top])
                }
                
                Image(.achievementsTextArgosy)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                
                ScrollView {
                    
                    VStack {
                        
                        HStack {
                            
                            VStack {
                                Image(viewModel.achievements[0].image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 300:150)
                                    .opacity(viewModel.achievements[0].isAchieved ? 1 : 0.3)
                                
                            }.onTapGesture {
                                viewModel.achieveToggle(viewModel.achievements[0])
                            }
                            Spacer()
                            
                        }
                        
                        HStack {
                            Spacer()
                            VStack {
                                Image(viewModel.achievements[1].image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 300:150)
                                    .opacity(viewModel.achievements[1].isAchieved ? 1 : 0.3)
                                
                            }.onTapGesture {
                                viewModel.achieveToggle(viewModel.achievements[1])
                            }
                        }
                        
                        HStack {
                            VStack {
                                Image(viewModel.achievements[2].image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 300:150)
                                    .opacity(viewModel.achievements[2].isAchieved ? 1 : 0.3)
                                
                            }.onTapGesture {
                                viewModel.achieveToggle(viewModel.achievements[2])
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            VStack {
                                Image(viewModel.achievements[3].image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 300:150)
                                    .opacity(viewModel.achievements[3].isAchieved ? 1 : 0.3)
                                
                            }.onTapGesture {
                                viewModel.achieveToggle(viewModel.achievements[3])
                            }
                        }
                        
                        HStack {
                            VStack {
                                Image(viewModel.achievements[4].image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 300:150)
                                    .opacity(viewModel.achievements[4].isAchieved ? 1 : 0.3)
                                
                            }.onTapGesture {
                                viewModel.achieveToggle(viewModel.achievements[4])
                            }
                            Spacer()
                        }
                        
                    }
                    
                }.padding(.horizontal)
                
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
}

#Preview {
    ArgosyAchievementsView(viewModel: ArgosyAchievementsViewModel())
}
