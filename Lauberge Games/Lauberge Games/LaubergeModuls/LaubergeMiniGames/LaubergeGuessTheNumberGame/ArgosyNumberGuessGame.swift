import SwiftUI

struct ArgosyNumberGuessGame: View {
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
                VStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? 40:20) {
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

                    Image(.guessTheNumTextArgosy)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                    
                    ZStack {
                        
                        Image(.guessNumGameBgArgosy)
                            .resizable()
                            .scaledToFit()
                        VStack {
                            
                            HStack(spacing: 16) {
                                ForEach(0..<3) { idx in
                                    ZStack {
                                        Image(.numBgArgosy)
                                            .resizable()
                                            .scaledToFit()
                                        
                                        Text( idx < guessDigits.count ? guessDigits[idx] : "" )
                                            .font(.system(size: 36, weight: .bold))
                                            .foregroundColor(.white)
                                    }.frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 150:100, height: ArgosyDeviceManager.shared.deviceType == .pad ? 150:100)
                                }
                            }
                            .padding(.vertical)
                            
                            
                            let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
                            LazyVGrid(columns: columns, spacing: ArgosyDeviceManager.shared.deviceType == .pad ? 24:12) {
                                ForEach(padNumbers, id: \ .self) { num in
                                    Button(action: { numberPressed(num) }) {
                                        ZStack {
                                            Image(.keyBoardBtnArgosy)
                                                .resizable()
                                                .scaledToFit()
                                            Text("\(num)")
                                                .font(.system(size: ArgosyDeviceManager.shared.deviceType == .pad ? 72:36, weight: .bold))
                                                .foregroundColor(.white)
                                        }.frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 144:72, height: ArgosyDeviceManager.shared.deviceType == .pad ? 144:72)
                                    }
                                    .disabled(guessDigits.count >= 3)
                                }
                            }.frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 480:240)
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
                            Image(.guessHigherArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 500:250)
                        } else if Int(guessDigits.joined()) ?? 0 > target{
                            Image(.guessLowerArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 500:250)
                        } else {
                            ZStack {
                                VStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? -60:-30) {
                                    Image(.winTextArgosy)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 500:250)
                                    
                                    Button {
                                        resetGame()
                                    } label: {
                                        Image(.getTextArgosy)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 120:60)
                                    }
                                }
                            }
                        }
                    }
                    
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
            ArgosyUser.shared.updateUserMoney(for: 100)
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
    ArgosyNumberGuessGame()
}
