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
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            game.dealCards(numberOfCards: numberOfCards)
        }
    }
    
    func chooseCard(card: Card) {
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            game.choose(card: card)
        }
    }
    
    func newGame() {
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            game = SetGameViewModel.createGame()
            dealCards(numberOfCards: Constants.initialDealCardsAmount)
        }
    }
    
    var dealtCards: [Card] {
        game.dealtCards
    }
    
    var deck: [Card] {
        game.deck
    }
}

private struct Constants {
    static let initialDealCardsAmount = 12
    static let animationDuration = 0.6
}
