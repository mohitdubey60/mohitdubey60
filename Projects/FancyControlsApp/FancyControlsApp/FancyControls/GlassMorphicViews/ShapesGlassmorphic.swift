//
//  ShapesGlassmorphic.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 07/12/22.
//

import SwiftUI

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.maxX * 0.25, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.maxX * 0.75, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
        
        return path
    }
}

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        let yTopPosition = rect.minY + (rect.maxY * 0.25)
        let yBottomPosition = rect.minY + (rect.maxY * 0.75)
        let path = Path { path in
            
            path.move(to: CGPoint(x: rect.minX, y: rect.minY + yTopPosition))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: yTopPosition), control: CGPoint(x: rect.maxX * 0.25, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: yTopPosition), control: CGPoint(x: rect.maxX * 0.75, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: yBottomPosition))
            
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: yBottomPosition), control: CGPoint(x: rect.maxX * 0.75, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: yBottomPosition), control: CGPoint(x: rect.maxX * 0.25, y: rect.midY))
            
            path.addLine(to: CGPoint(x: rect.minX, y: yTopPosition))
            
        }
        
        return path
    }
}

struct TopRoundedCornerRectangleShape: Shape {
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = Path { path in
            path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))
            
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            
            path.addArc(
                center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false
            )
        }
        
        return path
    }
}

struct TrapezoidShape: Shape {
    var xLeft: CGFloat = 0
    var xRight: CGFloat = 0
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(xLeft, xRight)
        }
        set {
            xLeft = newValue.first
            xRight = newValue.second
        }
    }
    func path(in rect: CGRect) -> Path {
        let path = Path { path in
            path.move(to: CGPoint(x: rect.minX + (rect.maxX * 0.20), y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + (rect.maxX * 0.80), y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - (rect.maxX * xRight), y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + (rect.maxX * xLeft), y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + (rect.maxX * 0.20), y: rect.minY))
        }
        
        return path
    }
}

struct PacmanShape: Shape {
    var mouthAngle: Double
    var animatableData: Double {
        get { mouthAngle }
        set { mouthAngle = newValue }
    }
    func path(in rect: CGRect) -> Path {
        let path = Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: mouthAngle),
                endAngle: Angle(degrees: 360 - mouthAngle),
                clockwise: false
            )
        }
        
        return path
    }
}
