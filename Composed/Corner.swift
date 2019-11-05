//
//  Corner.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import CoreGraphics

/// A representation of a corner in a `CGRect`.
public enum Corner {
    
    /// Represents the top left corner of a `CGRect`.
    ///
    /// The top left refers to the `minX` and `minY` coordinates of a `CGRect`.
    case topLeft(CGPoint)
    
    /// Represents the top right corner of a `CGRect`.
    ///
    /// The top left refers to the `maxX` and `minY` coordinates of a `CGRect`.
    case topRight(CGPoint)
    
    /// Represents the bottom left corner of a `CGRect`.
    ///
    /// The top left refers to the `minX` and `maxY` coordinates of a `CGRect`.
    case bottomLeft(CGPoint)
    
    /// Represents the bottom right corner of a `CGRect`.
    ///
    /// The top left refers to the `maxX` and `maxY` coordinates of a `CGRect`.
    case bottomRight(CGPoint)

//  TODO: topLeading, topTrailing, bottomLeading, bottomTrailing
    
    /// Returns a `CGRect` with the given `size` and whose `origin` is derived from the receiver.
    ///
    /// - Parameters:
    ///   - size: The size of the `CGRect` to be created.
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
    
    /// Returns the `CGPoint` value associated with the receiver.
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

/// A representation of all four corners of a `CGRect` instance.
public struct Corners {
    
    fileprivate let rect: CGRect
    
    fileprivate init(of rect: CGRect) {
        self.rect = rect
    }
    
    /// Returns the `minX` and `minY` coordinates of the `CGRect` as a `Corner`.
    public var topLeft: Corner { return .topLeft(CGPoint(x: rect.minX, y: rect.minY)) }
    
    /// Returns the `maxX` and `minY` coordinates of the `CGRect` as a `Corner`.
    public var topRight: Corner { return .topRight(CGPoint(x: rect.maxX, y: rect.minY)) }
    
    /// Returns the `minX` and `maxY` coordinates of the `CGRect` as a `Corner`.
    public var bottomLeft: Corner { return .bottomLeft(CGPoint(x: rect.minX, y: rect.maxY)) }
    
    /// Returns the `maxX` and `maxY` coordinates of the `CGRect` as a `Corner`.
    public var bottomRight: Corner { return .bottomRight(CGPoint(x: rect.maxX, y: rect.maxY)) }
}

public extension CGRect {
    
    /// Returns a `Corners` instance based on the receiver.
    var corners: Corners { return Corners(of: self) }
}

public extension CGSize {
    
    /// Returns a `CGRect` with the size of the receiver
    /// and whose `origin` is derived from the corner.
    ///
    /// - Parameters:
    ///   - corner: The corner from whose coordinates the origin of the rect is derived.
    func setCorner(_ corner: Corner) -> CGRect { return corner.rectWithSize(self) }
}
