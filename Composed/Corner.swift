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
    
    func rectWithSize(_ size: CGSize) -> CGRect {
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
}

public struct Corners {
    fileprivate let rect: CGRect
    
    init(of rect: CGRect) {
        self.rect = rect
    }
    
    var topLeft: Corner { return .topLeft(CGPoint(x: rect.minX, y: rect.minY)) }
    var topRight: Corner { return .topRight(CGPoint(x: rect.maxX, y: rect.minY)) }
    var bottomLeft: Corner { return .bottomLeft(CGPoint(x: rect.minX, y: rect.maxY)) }
    var bottomRight: Corner { return .bottomRight(CGPoint(x: rect.maxX, y: rect.maxY)) }
}

public extension CGRect {
    var corners: Corners { return Corners(of: self) }
}

public extension CGSize {
    func atCorner(_ corner: Corner) -> CGRect { return corner.rectWithSize(self) }
}
