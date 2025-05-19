import SwiftUI

struct ArgosySettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var settingsVM: ArgosySettingsViewModel
    var body: some View {
        ZStack {
            
            VStack {
                
                
                Spacer()
                
                ZStack {
                    
                    HStack(spacing: 10) {
                        
                        Button {
                            withAnimation {
                                settingsVM.soundEnabled.toggle()
                            }
                        } label: {
                            
                            Image(settingsVM.soundEnabled ? .soundOnLauberge:.soundOffLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 200:100, height: ArgosyDeviceManager.shared.deviceType == .pad ? 140:70)
                        }
                        
                        
                        Button {
                            withAnimation {
                                settingsVM.musicEnabled.toggle()
                            }
                        } label: {
                            
                            Image(settingsVM.musicEnabled ? .musicOnLauberge:.musicOffLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 200:100,height: ArgosyDeviceManager.shared.deviceType == .pad ? 140:70)
                        }
                        
                        
                    }
                    
                    
                }.frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 342:171)
                Spacer()
                Image(.languageTextLauberge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 180:90)
                    .offset(y: -150)
                
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
                       
                        ArgosyCoinBg()
                    }.padding([.horizontal, .top])
                }.padding(.bottom, 40)
                
                Image(.settingsTextLauberge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 136:68)
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
    }
    
}

#Preview {
    ArgosySettingsView(settingsVM: ArgosySettingsViewModel())
}
