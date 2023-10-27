//
//  Card.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/19/23.
//

import Foundation

enum CardSymbol: CaseIterable {
    case diamond
    case squiggle
    case oval
}

enum CardColor: CaseIterable {
    case red
    case green
    case purple
}

enum CardShade: CaseIterable {
    case solid
    case shaded
    case nothing
}

enum CardSymbolCount: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
}

enum Statuses: Int, CaseIterable {
    case dealt = 1
    case inDeck = 2
    case selected = 3
    case matched = 4
}

typealias CardInfo = (symbol: CardSymbol, color: CardColor, shade: CardShade, symbolCount: Int, status: Statuses)

struct Card: Identifiable, Equatable {
    var id = UUID()
    var props: CardInfo
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
}
