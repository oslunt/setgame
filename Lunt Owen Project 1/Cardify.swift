//
//  Cardify.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/18/23.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    
    var card: Card
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(fillColor).stroke(.black)
                    content
                }
            }
        }
    }
    
    private func cornerRadius(for size: CGSize) -> Double {
        return min(size.width, size.height) * Constants.cornerRadiusMultiplier
    }
    
    private var fillColor: Color {
        if card.props.status == .matched {
            return Color.green.opacity(Constants.fillColorOpacity)
        } else if card.props.status == .selected {
            return Color.gray.opacity(Constants.fillColorOpacity)
        } else {
            return Color.white
        }
    }
    
    private struct Constants {
        static let cornerRadiusMultiplier: Double = 0.08
        static let fillColorOpacity: Double = 0.5
    }
}

extension View {
    func cardify(card: Card) -> some View {
        modifier(Cardify(card: card))
    }
}
