//
//  SetGame.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/19/23.
//

import Foundation

struct SetGame {
    var deck: [Card] = {
        var deck = [Card]()
        
        for symbolCount in CardSymbolCount.allCases {
            for shade in CardShade.allCases {
                for color in CardColor.allCases {
                    for symbol in CardSymbol.allCases {
                        deck.append(Card(props: CardInfo(symbol: symbol, color: color, shade: shade, symbolCount: symbolCount.rawValue, status: .unselected)))
                    }
                }
            }
        }
        deck.shuffle()
        return deck.shuffled()
    }()
    
    private(set) var isMatched = false
    
    var dealtCards: [Card] = []
    
    var selectedCards: [Card] {
        dealtCards.filter() {$0.props.status == .selected}
    }
    
    mutating func dealCards(numberOfCards: Int) {
        if deck.count >  0 {
            if isMatched {
                isMatched.toggle()
                removeAndReplace()
            } else {
                for i in 0..<numberOfCards {
                    dealtCards.append(deck[i])
                }
                for _ in 0..<numberOfCards {
                    deck.remove(at: 0)
                }
            }
        }
    }
    
    // Removes matching cards and replaces them in place
    mutating func removeAndReplace() {
        for i in 0..<dealtCards.count {
            if dealtCards[i].props.status == .matched {
                dealtCards[i] = deck[0]
                deck.remove(at: 0)
            }
        }
    }
    
    // Just removes matching cards
    mutating func removeMatches() {
        for card in dealtCards {
            if card.props.status == .matched {
                if let index = dealtCards.firstIndex(of: card) {
                    dealtCards.remove(at: index)
                }
            }
        }
    }
    
    mutating func choose(card: Card) {
        if isMatched {
            isMatched.toggle()
            if deck.count > 0 && dealtCards.count == Constants.baseNumberOfCardsInPlay{
                removeAndReplace()
            } else {
                removeMatches()
            }
        }
        if selectedCards.count == Constants.maxSelectedCards {
            unselectSelectedCards()
        }
        if let selectedCardIndex = dealtCards.firstIndex(of: card) {
            if dealtCards[selectedCardIndex].props.status == .selected {
                dealtCards[selectedCardIndex].props.status = .unselected
            } else {
                dealtCards[selectedCardIndex].props.status = .selected
            }
        }
        if selectedCards.count == Constants.maxSelectedCards {
            isMatched = checkIfCardsMatch()
            if isMatched {
                markSelectedCardsAsMatched()
            }
        }
    }
    
    // Unselects all of the current selected cards, happens when there is no match
    mutating func unselectSelectedCards() {
        for selectedCard in dealtCards {
            if selectedCard.props.status == .selected {
                if let selectedCardIndex = dealtCards.firstIndex(of: selectedCard) {
                    dealtCards[selectedCardIndex].props.status = .unselected
                }
            }
        }
    }
    
    mutating func markSelectedCardsAsMatched() {
        for matchingCard in dealtCards {
            if matchingCard.props.status == .selected {
                if let matchingCardIndex = dealtCards.firstIndex(of: matchingCard) {
                    dealtCards[matchingCardIndex].props.status = .matched
                }
            }
        }
    }
    
    // Checks to see if each of the attributes of a card match the matching conditions
    func checkIfCardsMatch() -> Bool {
        let symbolCount = matchConditions(prop1: selectedCards[0].props.symbolCount, prop2: selectedCards[1].props.symbolCount, prop3: selectedCards[2].props.symbolCount)
        let shade = matchConditions(prop1: selectedCards[0].props.shade, prop2: selectedCards[1].props.shade, prop3: selectedCards[2].props.shade)
        let color = matchConditions(prop1: selectedCards[0].props.color, prop2: selectedCards[1].props.color, prop3: selectedCards[2].props.color)
        let symbol = matchConditions(prop1: selectedCards[0].props.symbol, prop2: selectedCards[1].props.symbol, prop3: selectedCards[2].props.symbol)
        return symbolCount && shade && color && symbol
    }
    
    // Matching conditions are if the property is all the same or all different
    func matchConditions<Prop: Equatable>(prop1: Prop, prop2: Prop, prop3: Prop) -> Bool {
        return (prop1 == prop2 && prop2 == prop3 && prop3 == prop1) || (prop1 != prop2 && prop2 != prop3 && prop3 != prop1)
    }
}

private struct Constants {
    static let maxSelectedCards = 3
    static let baseNumberOfCardsInPlay = 12
}
