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
        return min(size.width, size.height) * 0.08
    }
    
    private var fillColor: Color {
        if card.props.status == .matched {
            return Color.green.opacity(0.5)
        } else if card.props.status == .selected {
            return Color.gray.opacity(0.5)
        } else {
            return Color.white
        }
    }
}

extension View {
    func cardify(card: Card) -> some View {
        modifier(Cardify(card: card))
    }
}
