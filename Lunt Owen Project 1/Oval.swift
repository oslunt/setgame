//
//  Oval.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/18/23.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let halfWidth = width / 2

        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY - halfWidth), radius: halfWidth, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)

        
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY + halfWidth), radius: halfWidth, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: false)
        
        
        let topLineStart = CGPoint(x: rect.minX, y: rect.maxY - halfWidth)
        let topLineEnd = CGPoint(x: rect.minX, y: rect.minY + halfWidth)
        let bottomLineStart = CGPoint(x: rect.maxX, y: rect.maxY - halfWidth)
        let bottomLineEnd = CGPoint(x: rect.maxX, y: rect.minY + halfWidth)

        path.move(to: topLineStart)
        path.addLine(to: topLineEnd)

        path.move(to: bottomLineStart)
        path.addLine(to: bottomLineEnd)
        
        
        return path
    }
}
