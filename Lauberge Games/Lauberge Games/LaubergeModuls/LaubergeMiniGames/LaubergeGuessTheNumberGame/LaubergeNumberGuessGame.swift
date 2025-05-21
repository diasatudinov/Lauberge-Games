import SwiftUI

struct LaubergeNumberGuessGame: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var target = Int.random(in: 100...999)
    @State private var guessDigits: [String] = []
    @State private var feedback: String = ""
    @State private var attempts = 0
    
    private let padNumbers = [1, 2, 3,
                              4, 5, 6,
                              7, 8, 9,
                              0]
    

        var body: some View {
            ZStack {
                VStack(spacing: LaubergeDeviceManager.shared.deviceType == .pad ? 40:20) {
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

                    Image(.guessTheNumTextLauberge)
                        .resizable()
                        .scaledToFit()
                        .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 210:105)
                    
                    ZStack {
                        
                        Image(.guessNumGameBgLauberge)
                            .resizable()
                            .scaledToFit()
                        VStack {
                            
                            HStack(spacing: 16) {
                                ForEach(0..<3) { idx in
                                    ZStack {
                                        Image(.numBgLauberge)
                                            .resizable()
                                            .scaledToFit()
                                        
                                        Text( idx < guessDigits.count ? guessDigits[idx] : "" )
                                            .font(.system(size: 36, weight: .bold))
                                            .foregroundColor(.white)
                                    }.frame(width: LaubergeDeviceManager.shared.deviceType == .pad ? 150:103, height: LaubergeDeviceManager.shared.deviceType == .pad ? 150:103)
                                }
                            }
                            .padding(.vertical)
                            
                            
                            let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
                            LazyVGrid(columns: columns, spacing: LaubergeDeviceManager.shared.deviceType == .pad ? 24:12) {
                                ForEach(padNumbers, id: \ .self) { num in
                                    Button(action: { numberPressed(num) }) {
                                        ZStack {
                                            Image(.keyBoardBtnLauberge)
                                                .resizable()
                                                .scaledToFit()
                                            Text("\(num)")
                                                .font(.system(size: LaubergeDeviceManager.shared.deviceType == .pad ? 72:36, weight: .bold))
                                                .foregroundColor(.white)
                                        }.frame(width: LaubergeDeviceManager.shared.deviceType == .pad ? 144:100, height: LaubergeDeviceManager.shared.deviceType == .pad ? 144:100)
                                    }
                                    .disabled(guessDigits.count >= 3)
                                }
                            }.frame(width: LaubergeDeviceManager.shared.deviceType == .pad ? 480:310)
                                .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
                
                if !feedback.isEmpty {
                    Text(feedback)
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 10)
                        .shadow(radius: 2)
                    
                    ZStack {
                        
                        if Int(guessDigits.joined()) ?? 0 < target {
                            Image(.guessHigherLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 260:130)
                        } else if Int(guessDigits.joined()) ?? 0 > target{
                            Image(.guessLowerLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 260:130)
                        } else {
                            ZStack {
                                
                                Color.black.opacity(0.5).ignoresSafeArea()
                                VStack {
                                    
                                    Image(.winBgLauberge)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 400:223)
                                    Button {
                                        presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        Image(.nextLvlBtnLauberge)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 200:105)
                                    }
                                    
                                    Button {
                                        resetGame()
                                    } label: {
                                        Image(.restartBtnLauberge)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 200:105)
                                    }
                                    
                                    Button {
                                        presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        Image(.backBtnLauberge)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 200:105)
                                    }
                                    
                                }.padding(.bottom, LaubergeDeviceManager.shared.deviceType == .pad ? 100 : 50)
                            }
                        }
                    }
                    
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

    private func numberPressed(_ num: Int) {
        guard guessDigits.count < 3 else { return }
        guessDigits.append("\(num)")
        if guessDigits.count == 3 {
            evaluateGuess()
        }
    }

    private func evaluateGuess() {
        let guess = Int(guessDigits.joined()) ?? 0
        attempts += 1
        if guess < target {
            feedback = "Too low!"
        } else if guess > target {
            feedback = "Too high!"
        } else {
            feedback = "You got it in \(attempts) tries!"
            LaubergeUser.shared.updateUserMoney(for: 100)
        }
        if feedback.starts(with: "You got it") {
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // clear digits but keep target and attempts
                guessDigits = []
                feedback = ""
            }
        }
    }

    private func resetGame() {
        target = Int.random(in: 100...999)
        guessDigits = []
        feedback = ""
        attempts = 0
    }
}

#Preview {
    LaubergeNumberGuessGame()
}
