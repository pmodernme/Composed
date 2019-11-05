//
//  CGPoint+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/4/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import CoreGraphics

public extension CGPoint {
    
    /// Returns a point that is offset from that of the receiver.
    ///
    /// - Parameters:
    ///   - offset: The offset values for the x and y coordinates.
    ///
    /// - Returns:
    ///   A point that is offset by the x value of `offset` in the x-axis
    ///   and by its y value in the y-axis with respect to the receiver.
    func offset(by offset: CGPoint) -> CGPoint {
        return self + offset
    }
    
    /// Returns a point that is offset from that of the receiver.
    ///
    /// - Parameters:
    ///   - dx: The offset value for the x-coordinate.
    ///   - dy: The offset value for the y-coordinate.
    ///
    /// - Returns:
    ///   A point that is offset from the receiver by `dx` units
    ///   along the x-axis and `dy` units along the y-axis.
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return offset(by: CGPoint(x: dx, y: dy))
    }
}

extension CGPoint: AdditiveArithmetic {
    
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }
    
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return lhs + -rhs
    }
    
    
    public static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    public static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    
    public static prefix func - (value: CGPoint) -> CGPoint {
        return CGPoint(x: -value.x, y: -value.y)
    }
}
