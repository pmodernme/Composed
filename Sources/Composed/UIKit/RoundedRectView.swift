//
//  RoundedRectView.swift
//  
//
//  Created by Zoe Van Brunt on 3/9/23.
//

import UIKit

public class RoundedRectView: UIView {
    public var corners: UIRectCorner = .allCorners { didSet {
        setNeedsDisplay()
    }}
    public var color: UIColor = .white { didSet {
        setNeedsDisplay()
    }}
    public var cornerRadius: CGFloat = 12 { didSet {
        setNeedsDisplay()
    }}
    
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        
        context.beginPath()
        
        if corners.contains(.topLeft) {
            let radius = radius(for: .topLeft, in: rect)
            if corners.contains(.bottomLeft) {
                context.move(to: CGPoint(x: rect.minX, y: rect.midY))
            } else {
                context.move(to: rect.corners.bottomLeft.point)
            }
            context.addArc(
                tangent1End: rect.corners.topLeft.point,
                tangent2End: rect.corners.topLeft.point.offsetBy(dx: radius, dy: 0),
                radius: radius
            )
        } else {
            context.move(to: rect.corners.topLeft.point)
        }
        
        if corners.contains(.topRight) {
            let radius = radius(for: .topRight, in: rect)
            context.addArc(
                tangent1End: rect.corners.topRight.point,
                tangent2End: rect.corners.topRight.point.offsetBy(dx: 0, dy: radius),
                radius: radius
            )
        } else {
            context.addLine(to: rect.corners.topRight.point)
        }
        
        if corners.contains(.bottomRight) {
            let radius = radius(for: .bottomRight, in: rect)
            context.addArc(
                tangent1End: rect.corners.bottomRight.point,
                tangent2End: rect.corners.bottomRight.point.offsetBy(dx: -radius, dy: 0),
                radius: radius
            )
        } else {
            context.addLine(to: rect.corners.bottomRight.point)
        }
        
        if corners.contains(.bottomLeft) {
            let radius = radius(for: .bottomLeft, in: rect)
            context.addArc(
                tangent1End: rect.corners.bottomLeft.point,
                tangent2End: rect.corners.bottomLeft.point.offsetBy(dx: 0, dy: -radius),
                radius: radius
            )
        } else {
            context.addLine(to: rect.corners.bottomLeft.point)
        }
        
        context.closePath()
        
        context.setFillColor(color.cgColor)
        context.fillPath()
    }
    
    private func radius(for thisCorner: UIRectCorner, in rect: CGRect) -> CGFloat {
        guard corners.contains(thisCorner) else { return 0 }
        
        var r = cornerRadius
        switch thisCorner {
            case .topLeft:
                let p = rect.corners.topLeft.point
                if corners.contains(.topRight) {
                    let dx = rect.corners.topRight.point.x - p.x
                    r = min(r, dx/2)
                }
                if corners.contains(.bottomLeft) {
                    let dy = rect.corners.bottomLeft.point.y - p.y
                    r = min(r, dy/2)
                }
            case .topRight:
                let p = rect.corners.topRight.point
                if corners.contains(.topLeft) {
                    let dx = p.x - rect.corners.topLeft.point.x
                    r = min(r, dx/2)
                }
                if corners.contains(.bottomRight) {
                    let dy = rect.corners.bottomRight.point.y - p.y
                    r = min(r, dy/2)
                }
            case .bottomRight:
                let p = rect.corners.bottomRight.point
                if corners.contains(.bottomLeft) {
                    let dx = p.x - rect.corners.bottomLeft.point.x
                    r = min(r, dx/2)
                }
                if corners.contains(.topRight) {
                    let dy = p.y - rect.corners.topRight.point.y
                    r = min(r, dy/2)
                }
            case .bottomLeft:
                let p = rect.corners.bottomLeft.point
                if corners.contains(.bottomRight) {
                    let dx = rect.corners.bottomRight.point.x - p.x
                    r = min(r, dx/2)
                }
                if corners.contains(.topLeft) {
                    let dy = p.y - rect.corners.topLeft.point.y
                    r = min(r, dy/2)
                }
            default: break
        }
        
        return r
    }
}
