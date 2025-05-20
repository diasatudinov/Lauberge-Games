import SwiftUI

struct ArgosyMemorizationView: View {
    @StateObject var user = ArgosyUser.shared
    @Environment(\.presentationMode) var presentationMode
    
    let cardImages = ["cardFace1Argosy", "cardFace2Argosy", "cardFace3Argosy", "cardFace4Argosy", "cardFace5Argosy", "cardFace6Argosy"]
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
                                    Image(.backIconArgosy)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                                }
                                
                            }
                            Spacer()
                            
                            ArgosyCoinBg()
                        }.padding([.horizontal, .top])
                    }
                }
                
                Image(.simonSaysGameTextArgosy)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                
                Spacer()
                
                if gamePhase == .showing {
                    // Full-screen reveal of each card in sequence
                    if let idx = currentStep {
                        MemorizationCardView(imageName: cardImages[idx])
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 600:300)
                            .padding()
                            .transition(.opacity)
                    }
                } else {
                    // Grid for user interaction
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                        ForEach(0..<cardImages.count, id: \.self) { index in
                            MemorizationCardView(imageName: cardImages[index])
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
                        VStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? -60:-30) {
                            Image(.winTextArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 500:250)
                            
                            Button {
                                startGame()
                            } label: {
                                Image(.getTextArgosy)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 120:60)
                            }
                        }
                    }
                } else {
                    ZStack {
                        VStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? -60:-30) {
                            Image(.loseTextArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 500:250)
                            
                            Button {
                                startGame()
                            } label: {
                                Image(.restartBtnArgosy)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 120:60)
                            }
                        }
                    }
                }
                
            }
        }
        .background(
            ZStack {
                Image(.appBgArgosy)
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

struct MemorizationCardView: View {
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
    ArgosyMemorizationView()
}
