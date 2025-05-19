import SwiftUI

struct ArgosySettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var settingsVM: ArgosySettingsViewModel
    var body: some View {
        ZStack {
            
            VStack {
                
                
                
                ZStack {
                    Image(.settingsBgArgosy)
                        .resizable()
                        .scaledToFit()
                    HStack(spacing: 10) {
                        
                        Button {
                            withAnimation {
                                settingsVM.soundEnabled.toggle()
                            }
                        } label: {
                            
                            Image(settingsVM.soundEnabled ? .soundOnArgosy:.soundOffArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 200:100, height: ArgosyDeviceManager.shared.deviceType == .pad ? 140:70)
                        }
                        
                        
                        Button {
                            withAnimation {
                                settingsVM.musicEnabled.toggle()
                            }
                        } label: {
                            
                            Image(settingsVM.musicEnabled ? .musicOnArgosy:.musicOffArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 200:100,height: ArgosyDeviceManager.shared.deviceType == .pad ? 140:70)
                        }
                        
                        
                    }
                    
                    
                }.frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 342:171)
            }
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
                       
                        ArgosyCoinBg()
                    }.padding([.horizontal, .top])
                }.padding(.bottom, 40)
                
                Image(.settingsTextArgosy)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
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
    ArgosySettingsView(settingsVM: ArgosySettingsViewModel())
}
