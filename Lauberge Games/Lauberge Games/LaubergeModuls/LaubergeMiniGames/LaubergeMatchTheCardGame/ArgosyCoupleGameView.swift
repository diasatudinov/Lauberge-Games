//
//  ArgosyCoupleGameView.swift
//  Lauberge Games
//
//  Created by Dias Atudinov on 20.05.2025.
//


import SwiftUI

struct ArgosyCoupleGameView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var user = ArgosyUser.shared
    
    @State private var cards: [ArgosyCard] = []
    @State private var selectedCards: [ArgosyCard] = []
    @State private var message: String = "Find all matching cards!"
    @State private var gameEnded: Bool = false
    @State private var isWin: Bool = false
    @State private var pauseShow: Bool = false
    private let cardTypes = [
        "cardFace1Lauberge",
        "cardFace2Lauberge",
        "cardFace3Lauberge",
        "cardFace4Lauberge",
        "cardFace5Lauberge",
        "cardFace6Lauberge"]
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
                            Image(.backIconLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        
                        Spacer()
                        
                        ArgosyCoinBg()
                    }.padding(.horizontal)
                    
                    VStack(spacing: ArgosyDeviceManager.shared.deviceType == .pad ? -40:-20) {
                        Image(.findCoupleTextLauberge)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 136:68)
                        
                        ZStack {
                            
                            Text("\(timeLeft)")
                                .font(.system(size: ArgosyDeviceManager.shared.deviceType == .pad ? 40:20, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer()
                    ZStack {
                        Image(.guessNumGameBgLauberge)
                            .resizable()
                            .scaledToFit()
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
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
                        
                        Color.black.opacity(0.5).ignoresSafeArea()
                        VStack {
                            
                            Image(.winBgLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 400:223)
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.nextLvlBtnLauberge)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 200:105)
                            }
                            
                            Button {
                                setupGame()
                            } label: {
                                Image(.restartBtnLauberge)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 200:105)
                            }
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.backBtnLauberge)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 200:105)
                            }
                            
                        }.padding(.bottom, ArgosyDeviceManager.shared.deviceType == .pad ? 100 : 50)
                    }
                } else {
                    ZStack {
                        
                        Color.black.opacity(0.5).ignoresSafeArea()
                        VStack {
                            
                            Image(.loseBgLauberge)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 400:223)
                            
                            Button {
                                setupGame()
                            } label: {
                                Image(.restartBtnLauberge)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 200:105)
                            }
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.backBtnLauberge)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 200:105)
                            }
                            
                        }.padding(.bottom, ArgosyDeviceManager.shared.deviceType == .pad ? 100 : 50)
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
            Image(.appBgLauberge)
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
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:100)
            } else {
                Image(.keyBoardBtnLauberge)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ArgosyDeviceManager.shared.deviceType == .pad ? 210:100)
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
