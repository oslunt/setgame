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
    case unselected = 1
    case selected = 2
    case matched = 3
}

typealias CardInfo = (symbol: CardSymbol, color: CardColor, shade: CardShade, symbolCount: Int, status: Statuses)

struct Card: Identifiable, Equatable {
    var id = UUID()
    var props: CardInfo
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
}
