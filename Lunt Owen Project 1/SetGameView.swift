//
//  ContentView.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/16/23.
//

import SwiftUI

struct SetGameView: View {
    
    
    let setGame: SetGameViewModel
    
    var body: some View {
            VStack {
                GeometryReader { geomtry in
                    LazyVGrid(columns: columns(for: geomtry.size), spacing: Game.spacing) {
                        ForEach(setGame.dealtCards) { card in
                            CardView(card: card)
                                .transition(AnyTransition.offset(randomOffScreenLocation))
                                .onTapGesture {
                                    setGame.chooseCard(card: card)
                                }
                        }
                    }.onAppear(perform: {
                        setGame.dealCards(numberOfCards: Game.initialDeal)
                    })
                }
                Spacer(minLength: 0)
                HStack {
                    Button("New Game") {
                        setGame.newGame()
                    }
                    Spacer()
                    Button("Deal 3 Cards") {
                        setGame.dealCards(numberOfCards: Game.dealThree)
                    }.disabled(checkDisableDeal3())
                }
            }
            .padding()
    }
    
    // Determines the number of columns
    private func columns(for size: CGSize) -> [GridItem]{
        var columns = Game.initialColumns
        let visibleCards = setGame.dealtCards.count
        var width = size.width
        let height = size.height - Game.heightSpacingSubtractor
        var rows = Game.initialRows
        repeat {
            columns += 1
            width = size.width / columns
            rows = ceil(Double(visibleCards) / columns)
        } while ((width / Game.aspectRatio) * rows) > height
        return Array(repeating: GridItem(.flexible()), count: Int(columns))
    }
    
    private func checkDisableDeal3() -> Bool {
        if setGame.deck.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    // Figures out a random offscreen location to shoot cards in from
    private var randomOffScreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * Game.radiusMultiplier
        let factor: Double = Int.random(in: 0...1) > 0 ? 1 : -1
        return CGSize(width: factor * radius, height: factor * radius)
    }
    
    private struct Game {
        static let radiusMultiplier = 1.5
        static let initialColumns = 2.0
        static let initialRows = 4.0
        static let heightSpacingSubtractor = 30.0
        static let aspectRatio = 1.4
        static let dealThree = 3
        static let initialDeal = 12
        static let spacing = 5.0
    }
}


#Preview {
    SetGameView(setGame: SetGameViewModel())
}
