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
                    LazyVGrid(columns: columns(for: geomtry.size), spacing: 5) {
                        ForEach(setGame.dealtCards) { card in
                            CardView(card: card)
                                .transition(AnyTransition.offset(randomOffScreenLocation))
                                .onTapGesture {
                                    setGame.selectCard(card: card)
                                }
                        }
                    }.onAppear(perform: {
                        setGame.dealCards(numberOfCards: 12)
                    })
                }
                Spacer(minLength: 0)
                HStack {
                    Button("New Game") {
                        setGame.newGame()
                    }.transition(AnyTransition.offset(randomOffScreenLocation))
                    Spacer()
                    Button("Deal 3 Cards") {
                        setGame.dealCards(numberOfCards: 3)
                    }
                }
            }
            .padding()
    }
    
    private func columns(for size: CGSize) -> [GridItem]{
        var columns = 2.0
        let visibleCards = setGame.dealtCards.count
        var width = size.width
        let height = size.height - 30
        var rows = 4.0
        repeat {            
            columns += 1
            width = size.width / columns
            rows = ceil(Double(visibleCards) / columns)
        } while ((width / 1.4) * rows) > height
        return Array(repeating: GridItem(.flexible()), count: Int(columns))
    }
    
    private var randomOffScreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let factor: Double = Int.random(in: 0...1) > 0 ? 1 : -1
        return CGSize(width: factor * radius, height: factor * radius)
    }
    private struct Game {
        static let desiredCardWidth = 120.0
        static let desiredCardHeight = 65.0
        static let maxWidth = 360.0
        static let maxHeight = 672.0
    }
}


#Preview {
    SetGameView(setGame: SetGameViewModel())
}
