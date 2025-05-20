import SwiftUI
import AVFoundation

struct ArgosyCoupleGameView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var user = ArgosyUser.shared
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var cards: [ArgosyCard] = []
    @State private var selectedCards: [ArgosyCard] = []
    @State private var message: String = "Find all matching cards!"
    @State private var gameEnded: Bool = false
    @State private var isWin: Bool = false
    @State private var pauseShow: Bool = false
    private let cardTypes = ["cardFace1Argosy", "cardFace2Argosy", "cardFace3Argosy", "cardFace4Argosy", "cardFace5Argosy", "cardFace6Argosy"]
    private let gridSize = 4
    
    @State private var counter: Int = 0
    
    @State private var timeLeft: Int = 60
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            
                VStack {
                    HStack {
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
                    }.padding(.horizontal)
                    
                    VStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? -40:-20) {
                        Image(.findCoupleTextArgosy)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
                        
                        ZStack {
                            Image(.coupleTimerBgArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 120:60)
                            
                            Text("\(timeLeft)")
                                .font(.system(size: ArgosyDeviceManager.shared.deviceType == .pad ? 40:20, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer()
                    ZStack {
                        Image(.findCoupleGameBgArgosy)
                            .resizable()
                            .scaledToFit()
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 0) {
                            ForEach(cards) { card in
                                ArgosyCardView(card: card)
                                    .onTapGesture {
                                        flipCard(card)
                                        
                                    }
                                    .opacity(card.isMatched ? 0.5 : 1.0)
                            }
                            
                        }
                        .frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 500:332)
                    }.frame(width: ArgosyDeviceManager.shared.deviceType == .pad ? 600:382)
                    
                    Spacer()
                }
                .onAppear {
                    setupGame()
                }
            
            if gameEnded {
                if isWin {
                    ZStack {
                        VStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? -60:-30) {
                            Image(.winTextArgosy)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 500:250)
                            
                            Button {
                                setupGame()
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
                                setupGame()
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
        .onReceive(timer) { _ in
            guard !gameEnded else { return }
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                gameEnded = true
                isWin = false
                timer.upstream.connect().cancel()
            }
        }
//        .onAppear {
//            startTimer()
//        }
        .background(
            Image(.appBgArgosy)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        
        
    }
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if counter < 4 {
                withAnimation {
                    counter += 1
                }
            }
        }
    }
    
    private func setupGame() {
        // Reset state
        selectedCards.removeAll()
        message = "Find all matching cards!"
        gameEnded = false
        timeLeft = 60
        // Restart timer
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        // Generate cards
        var gameCards = [ArgosyCard]()
        
        // Add 4 cards of each type (24 cards total for 6 types)
        for type in cardTypes {
            gameCards.append(ArgosyCard(type: type))
            gameCards.append(ArgosyCard(type: type))
        }
                
        // Shuffle cards
        gameCards.shuffle()
        
        // Ensure exactly 25 cards
        cards = Array(gameCards.prefix(gridSize * gridSize))
    }
    
    private func flipCard(_ card: ArgosyCard) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched,
              selectedCards.count < 2 else { return }
        
        // Flip card
        cards[index].isFaceUp = true
        selectedCards.append(cards[index])
        
        if card.type == "cardSemaphore" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                resetAllCards()
            }
        } else if selectedCards.count == 2 {
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let allMatch = selectedCards.allSatisfy { $0.type == selectedCards.first?.type }
        
        if allMatch {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isMatched = true
                }
            }
            message = "You found a match! Keep going!"
            isWin = true
        } else {
            message = "Not a match. Try again!"
            isWin = false
        }
        
        // Flip cards back over after a delay if they don't match
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isFaceUp = false
                }
            }
            selectedCards.removeAll()
            
            // Check if all cards are matched
            if cards.allSatisfy({ $0.isMatched || $0.type == "cardSemaphore" }) {
                message = "Game Over! You found all matches!"
                gameEnded = true
                user.updateUserMoney(for: 100)
            }
        }
    }
    
    private func resetAllCards() {
        message = "Red semaphore! All cards reset!"
        for index in cards.indices {
            cards[index].isFaceUp = false
            
            cards[index].isMatched = false
            
        }
        selectedCards.removeAll()
    }
    
}

#Preview {
    ArgosyCoupleGameView()
}

struct ArgosyCardView: View {
    let card: ArgosyCard

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                Image(card.type)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
            } else {
                Image(.cardBackArgosy)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:105)
            }
        }
    }
}


struct ArgosyCard: Identifiable {
    let id = UUID()
    let type: String
    var isFaceUp = false
    var isMatched = false
}
