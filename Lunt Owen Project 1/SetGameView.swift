//
//  ContentView.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/16/23.
//

import SwiftUI

struct SetGameView: View {
    
    private let size: CGFloat = 50.0
    
    let setGame: SetGameViewModel
    
    var body: some View {
        GeometryReader { geomtry in
            VStack {
                LazyVGrid(columns: columns(for: geomtry.size)) {
                    ForEach(setGame.dealtCards) { card in
                        CardView(card: card).onTapGesture {
                            setGame.selectCard(card: card)
                        }
                    }
                }
                Spacer(minLength: 0)
                HStack {
                    Button("New Game") {
                        setGame.newGame()
                    }
                    Spacer()
                    Button("Deal 3") {
                        setGame.dealCards(numberOfCards: 3)
                    }
                }
            }
            .padding()
        }
    }
    
    private func columns(for size: CGSize) -> [GridItem]{
        let columns = Int(round(size.width / Game.desiredCardWidth))
        //print((size.height / Game.desiredCardWidth))
        return Array(repeating: GridItem(.flexible(minimum: Game.desiredCardWidth)), count: columns)
        //Array(repeating: GridItem(.flexible()), count: Int(size.width / Game.desiredCa rdWidth))
    }
    
    private struct Game {
        static let desiredCardWidth = 115.0
        static let desiredCardHeight = 65.0
    }
}


#Preview {
    SetGameView(setGame: SetGameViewModel())
}
