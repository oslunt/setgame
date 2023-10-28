//
//  CardView.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/18/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        GeometryReader { geometry in
            createCard(size: geometry.size)
            .cardify(card: card)
        }
        .aspectRatio(CardConstants.aspectRatio, contentMode: .fit)
    }
    
    @ViewBuilder
    private func createCard(size: CGSize) -> some View {
        HStack {
            ForEach(0 ..< card.props.symbolCount, id: \.self) { _ in
                ZStack {
                    Group {
                        switch card.props.symbol {
                        case .oval:
                            Capsule().opacity(symbolOpacity)
                            Capsule().stroke(lineWidth: CardConstants.strokeWidth)
                        case .diamond:
                            Diamond().opacity(symbolOpacity)
                            Diamond().stroke(lineWidth: CardConstants.strokeWidth)
                        case .squiggle:
                            Squiggle().opacity(symbolOpacity)
                            Squiggle().stroke(lineWidth: CardConstants.strokeWidth)
                        }
                    }
                    .frame(height: size.height * CardConstants.heightRatio)
                    .aspectRatio(CardConstants.shapeAspectRatio, contentMode: .fit)
                }
            }
        }
        .foregroundColor(symbolColor)
        .frame(width: size.width * CardConstants.widthRatio)
    }
    
    private var symbolColor: Color {
        switch card.props.color {
            case .red:
                return Color.red
            case .green:
                return Color.green
            case .purple:
                return Color.purple
        }
    }
    
    private var symbolOpacity: Double {
        switch card.props.shade {
            case .nothing:
                return 0.0
            case .shaded:
                return 0.25
            case .solid:
                return 1.0
        }
    }
    
    private struct CardConstants {
        static let aspectRatio: Double = 7/5
        static let heightRatio: Double = 0.8
        static let widthRatio: Double = 0.8
        static let shapeAspectRatio: Double = 0.5
        static let strokeWidth: Double = 4.0
    }
}

#Preview {
    CardView(card: Card(props: CardInfo(symbol: CardSymbol.squiggle, color: CardColor.green, shade: CardShade.shaded, symbolCount: 3, status: .unselected)))
}
