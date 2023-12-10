//
//  CustomTrapezoid.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct CustomTrapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let topLeftPoint  = CGPoint(x: rect.minX, y: rect.minY)
        let botLeftPoint  = CGPoint(x: rect.minX, y: rect.maxY)
        let botRigthPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        let topRigthPoint = CGPoint(x: rect.midX, y: rect.minY)
        
        path.move(to: topLeftPoint)
        path.addLine(to: botLeftPoint)
        path.addLine(to: botRigthPoint)
        path.addLine(to: topRigthPoint)
        path.addLine(to: topLeftPoint)
        
        return path
    }
}
