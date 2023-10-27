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
        game.dealCards(numberOfCards: numberOfCards)
    }
    
    func selectCard(card: Card) {
        print("selectCard")
        game.select(card: card)
    }
    
    func newGame() {
        print("newGame")
        game = SetGameViewModel.createGame()
    }
    
    var dealtCards: [Card] {
        game.dealtCards
    }
}

private struct Constants {
    static let initialDealCardsAmount = 12
}
