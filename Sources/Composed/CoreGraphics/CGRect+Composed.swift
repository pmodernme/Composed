//
//  CGRect+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import CoreGraphics

public extension CGRect {
    
    /// Returns the center of the `CGRect`.
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
    /// Returns a rect with the same size as the receiver, but with an origin of CGPoint.zero
    var bounds: CGRect {
        return CGRect(origin: CGPoint.zero,
                      size: size)
    }
    
    func offset(by offset: CGPoint) -> CGRect {
        return offsetBy(dx: offset.x, dy: offset.y)
    }
    
    func insetEdgesBy(minX: CGFloat = 0, maxX: CGFloat = 0, minY: CGFloat = 0, maxY: CGFloat = 0) -> CGRect {
        var origin = self.origin
        var size = self.size
        origin = origin.offsetBy(dx: minX, dy: minY)
        size = CGSize(width: size.width - (minX + maxX), height: size.height - (minY + maxY))
        return CGRect(origin: origin, size: size)
    }
}
