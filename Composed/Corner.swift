//
//  Corner.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit

public enum Corner {
    case topLeft(CGPoint), topRight(CGPoint), bottomLeft(CGPoint), bottomRight(CGPoint)
    
//    TODO:
//    case topLeading, topTrailing, bottomLeading, bottomTrailing
    
    public func rectWithSize(_ size: CGSize) -> CGRect {
        switch self {
        case .topLeft(let point):
            return CGRect(origin: point, size: size)
        case .topRight(let point):
            return CGRect(
                x: point.x - size.width,
                y: point.y,
                width: size.width,
                height: size.height
            )
        case .bottomLeft(let point):
            return CGRect(
                x: point.x,
                y: point.y - size.height,
                width: size.width,
                height: size.height
            )
        case .bottomRight(let point):
            return CGRect(
                x: point.x - size.width,
                y: point.y - size.height,
                width: size.width,
                height: size.height
            )
        }
    }
    
    public var point: CGPoint {
        switch self {
        case .topLeft(let point):
            return point
        case .topRight(let point):
            return point
        case .bottomLeft(let point):
            return point
        case .bottomRight(let point):
            return point
        }
    }
}

public struct Corners {
    fileprivate let rect: CGRect
    
    fileprivate init(of rect: CGRect) {
        self.rect = rect
    }
    
    public var topLeft: Corner { return .topLeft(CGPoint(x: rect.minX, y: rect.minY)) }
    public var topRight: Corner { return .topRight(CGPoint(x: rect.maxX, y: rect.minY)) }
    public var bottomLeft: Corner { return .bottomLeft(CGPoint(x: rect.minX, y: rect.maxY)) }
    public var bottomRight: Corner { return .bottomRight(CGPoint(x: rect.maxX, y: rect.maxY)) }
}

public extension CGRect {
    var corners: Corners { return Corners(of: self) }
}

public extension CGSize {
    func setCorner(_ corner: Corner) -> CGRect { return corner.rectWithSize(self) }
}
