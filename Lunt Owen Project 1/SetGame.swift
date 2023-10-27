//
//  SetGame.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/19/23.
//

import Foundation

struct SetGame {
    static var deck: [Card] = {
        var deck = [Card]()
        
        for symbolCount in CardSymbolCount.allCases {
            for shade in CardShade.allCases {
                for color in CardColor.allCases {
                    for symbol in CardSymbol.allCases {
                        deck.append(Card(props: CardInfo(symbol: symbol, color: color, shade: shade, symbolCount: symbolCount.rawValue)))
                    }
                }
            }
        }
        deck.shuffle()
        for (index, var card) in deck.enumerated() {
            if index < 12 {
                card.props.status = .dealt
            } else {
                card.props.status = .inDeck
            }
        }
        return deck
    }()
    
    private(set) var isMatched = false
    
    var dealtCards: [Card] {
        SetGame.deck.filter() {$0.isDealt}
    }
    
    var selectedCards: [Card] {
        SetGame.deck.filter() {$0.isSelected}
    }
    
    mutating func dealCards(numberOfCards: Int) {
        if isMatched {
            isMatched.toggle()
            removeCardsFromPlay()
        }
        print(dealtCards.count)
        if cardsDealt < Constants.numCards {
            for cardsDealtIndex in cardsDealt ..< cardsDealt + numberOfCards {
                cardsDealtIndex < SetGame.deck.count ? SetGame.deck[cardsDealtIndex].isDealt.toggle() :
                    nil
            }
            cardsDealt += numberOfCards
        }
        
    }
    
    mutating func removeMatches() {
        for var card in selectedCards {
            if card.isMatched {
                print(card)
                card.isDealt.toggle()
                card.isSelected.toggle()
                print(card)
            }
        }
    }
    
    mutating func select(card: Card) {
        if isMatched {
            isMatched.toggle()
            removeCardsFromPlay()
            //print(dealtCards)
            if dealtCards.count < 12{
                dealCards(numberOfCards: 3)
            }
            //Take cards off the screen and add 3 new cards
        }
        if selectedCards.count == Constants.maxSelectedCards {
            unselectSelectedCards()
        }
        if let selectedCardIndex = SetGame.deck.firstIndex(of: card) {
            SetGame.deck[selectedCardIndex].isSelected.toggle()
        }
        if selectedCards.count == Constants.maxSelectedCards {
            isMatched = checkIfCardsMatch()
            if isMatched {
                markSelectedCards()
            }
        }
    }
    
    mutating func removeCardsFromPlay() {
        for selectedMatchedCard in selectedCards {
            if let selectedMatchedCardIndex = SetGame.deck.firstIndex(of: selectedMatchedCard) {
                SetGame.deck[selectedMatchedCardIndex].isMatched ? SetGame.deck[selectedMatchedCardIndex].isDealt.toggle() :
                    nil
            }
        }
    }
    
    mutating func unselectSelectedCards() {
        for selectedCard in selectedCards {
            if let selectedCardIndex = SetGame.deck.firstIndex(of: selectedCard) {
                SetGame.deck[selectedCardIndex].isSelected.toggle()
            }
        }
    }
    
    mutating func markSelectedCards() {
        for matchingCard in selectedCards {
            if let matchingCardIndex = SetGame.deck.firstIndex(of: matchingCard) {
                SetGame.deck[matchingCardIndex].isMatched.toggle()
            }
        }
    }
    
    func checkIfCardsMatch() -> Bool {
        let symbolCount = matchConditions(prop1: selectedCards[0].props.symbolCount, prop2: selectedCards[1].props.symbolCount, prop3: selectedCards[2].props.symbolCount)
        let shade = matchConditions(prop1: selectedCards[0].props.shade, prop2: selectedCards[1].props.shade, prop3: selectedCards[2].props.shade)
        let color = matchConditions(prop1: selectedCards[0].props.color, prop2: selectedCards[1].props.color, prop3: selectedCards[2].props.color)
        let symbol = matchConditions(prop1: selectedCards[0].props.symbol, prop2: selectedCards[1].props.symbol, prop3: selectedCards[2].props.symbol)
        return symbolCount && shade && color && symbol
    }
    
    func matchConditions<Prop: Equatable>(prop1: Prop, prop2: Prop, prop3: Prop) -> Bool {
        return (prop1 == prop2 && prop2 == prop3 && prop3 == prop1) || (prop1 != prop2 && prop2 != prop3 && prop3 != prop1)
    }
}

private struct Constants {
    static let numCards = 80
    static let maxSelectedCards = 3
}
