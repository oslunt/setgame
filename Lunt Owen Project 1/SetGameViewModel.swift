//
//  SetGameViewModel.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/19/23.
//

import SwiftUI

@Observable class SetGameViewModel {
    private var game = createGame()
    
    static func createGame() -> SetGame {
        SetGame()
    }
    
    func dealCards(numberOfCards: Int) {
        withAnimation(.easeIn(duration: 0.6)) {
            game.dealCards(numberOfCards: numberOfCards)
        }
    }
    
    func selectCard(card: Card) {
        withAnimation(.easeIn(duration: 0.6)) {
            game.choose(card: card)
        }
    }
    
    func newGame() {
        withAnimation(.easeIn(duration: 0.6)) {
            game = SetGameViewModel.createGame()
            dealCards(numberOfCards: Constants.initialDealCardsAmount)
        }
    }
    
    var dealtCards: [Card] {
        game.dealtCards
    }
}

private struct Constants {
    static let initialDealCardsAmount = 12
}
