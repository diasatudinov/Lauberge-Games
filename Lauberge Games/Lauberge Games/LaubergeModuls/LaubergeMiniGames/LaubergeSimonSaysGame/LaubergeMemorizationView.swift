import SwiftUI

struct LaubergeMemorizationView: View {
    @StateObject var user = LaubergeUser.shared
    @Environment(\.presentationMode) var presentationMode
    
    let cardImages = ["cardFace1Lauberge", "cardFace2Lauberge", "cardFace3Lauberge", "cardFace4Lauberge", "cardFace5Lauberge", "cardFace6Lauberge"]
    let sequenceLength = 3
    
    @State private var sequence: [Int] = []
    @State private var currentStep: Int? = nil
    @State private var gamePhase: GamePhase = .showing
    @State private var userInputIndex = 0
    @State private var feedback: String? = nil
    
    enum GamePhase {
        case showing
        case userTurn
        case finished
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        HStack(alignment: .top) {
                            HStack {
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                    
                                } label: {
                                    Image(.backIconLauberge)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 100:50)
                                }
                                
                            }
                            Spacer()
                            
                            LaubergeCoinBg()
                        }.padding([.horizontal, .top])
                    }
                }
                
                Image(.simonSaysGameTextLauberge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 136:68)
                
                Spacer()
                
                if gamePhase == .showing {
                    // Full-screen reveal of each card in sequence
                    if let idx = currentStep {
                        LaubergeMemorizationCardView(imageName: cardImages[idx])
                            .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 600:300)
                            .padding()
                            .transition(.opacity)
                    }
                } else {
                    // Grid for user interaction
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                        ForEach(0..<cardImages.count, id: \.self) { index in
                            LaubergeMemorizationCardView(imageName: cardImages[index])
                                .onTapGesture {
                                    handleTap(on: index)
                                }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                
            }
            
            if gamePhase == .finished {
                
                if userInputIndex >= sequenceLength {
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
                                startGame()
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
                } else {
                    ZStack {
                        
                        Color.black.opacity(0.5).ignoresSafeArea()
                        VStack {
                            
                            Image(.loseBgLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: LaubergeDeviceManager.shared.deviceType == .pad ? 400:223)
                            
                            Button {
                                startGame()
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
        .background(
            ZStack {
                Image(.appBgLauberge)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .onAppear {
            startGame()
        }
        .animation(.easeInOut, value: currentStep)
    }
    
    private var headerText: String {
        switch gamePhase {
        case .showing:
            return "Watch the sequence..."
        case .userTurn:
            return "Your turn: repeat the sequence"
        case .finished:
            return feedback ?? ""
        }
    }
    
    private func startGame() {
        sequence = Array(0..<cardImages.count).shuffled().prefix(sequenceLength).map { $0 }
        userInputIndex = 0
        feedback = nil
        gamePhase = .showing
        currentStep = nil
        
        Task {
            await revealSequence()
        }
    }
    
    @MainActor
    private func revealSequence() async {
        for idx in sequence {
            currentStep = idx
            try? await Task.sleep(nanoseconds: 800_000_000)
            currentStep = nil
            try? await Task.sleep(nanoseconds: 300_000_000)
        }
        gamePhase = .userTurn
    }
    
    private func handleTap(on index: Int) {
        guard gamePhase == .userTurn else { return }
        if index == sequence[userInputIndex] {
            userInputIndex += 1
            if userInputIndex >= sequenceLength {
                feedback = "Correct! You win!"
                user.updateUserMoney(for: 30)
                gamePhase = .finished
                
            }
        } else {
            feedback = "Wrong! Try again."
            gamePhase = .finished
        }
    }
}

struct LaubergeMemorizationCardView: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

#Preview {
    LaubergeMemorizationView()
}
