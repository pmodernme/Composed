//
//  CGSize+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import CoreGraphics

public extension CGSize {
    
    /// Returns a `CGRect` by placing the receiver at `origin`.
    ///
    /// - Parameters:
    ///   - origin: A `CGFloat` that will be used as the origin of the rect.
    func setOrigin(_ origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: self)
    }
    
    /// Returns a `CGRect` by centering the receiver at `center`.
    ///
    /// - Parameters:
    ///   - center: The center for the `CGRect`.
    func setCenter(_ center: CGPoint) -> CGRect {
        return CGRect(
            x: center.x - width/2 ,
            y: center.y - height/2,
            width: width,
            height: height)
    }
    
    func override(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
        var size = self
        if let width = width {
            size.width = width
        }
        if let height = height {
            size.height = height
        }
        return size
    }
    
    /// Returns a `CGSize` that is smaller or larger than the receiver.
    ///
    /// - Parameters:
    ///   - dx: The x-coordinate value to use for adjusting the
    ///   receiver. Specify a negative value to create a larger size.
    ///   - dy: The y-coordinate value to use for adjusting the
    ///   receiver. Specify a negative value to create a larger size.
    ///
    /// - Returns:
    ///   A `CGSize` adjusted by `(2*dx, 2*dy)`. If dx and dy
    ///   are positive values, then the size is decreased. If dx and dy
    ///   are negative values, the size is increased.
    func insetBy(dx: CGFloat, dy: CGFloat) -> CGSize {
        return CGSize(width: width - (2*dx), height: height - (2*dy))
    }
    
    func insetBy(size: CGSize) -> CGSize {
        return CGSize(width: width - size.width, height: height - size.height)
    }
    
    /// Returns a `CGSize` by adding `2*x` and `2*y` to
    /// the receiver's `width` and `height` respectively.
    ///
    /// - Parameters:
    ///   - dx: The value to add to `width`
    ///   - dy: The value to add to `height`
    func expandedBy(dx: CGFloat, dy: CGFloat) -> CGSize {
        return insetBy(dx: -dx, dy: -dy)
    }
    
    /// The `CGSize` whose `width` and `height`
    /// are both `CGFloat.greatestFiniteMagnitude`
    static var max: CGSize {
        return CGSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )
    }
    
    var integral: CGSize {
        return CGSize(
            width: ceil(width), height: ceil(height)
        )
    }
}

/// Returns a `CGSize` whose `width` and `height`
/// are the combined maximum of all `sizes`
///
/// - Parameters:
///   - sizes: A list of `CGSize` to compare.
public func union(_ sizes: CGSize...) -> CGSize {
    return sizes.union
}

/// Returns a `CGSize` whose `width` and `height`
/// are the combined minimum of all `sizes`
///
/// - Parameters:
///   - sizes: A list of `CGSize` to compare.
public func intersection(_ sizes: CGSize...) -> CGSize {
    return sizes.intersection
}

public extension Array where Element == CGSize {
    
    /// Returns a `CGSize` whose `width` and `height`
    /// are the combined maximum of all the array's contents.
    var union: CGSize {
        return processWidthAndHeight(initial: .zero, function: Swift.max)
    }
    
    /// Returns a `CGSize` whose `width` and `height`
    /// are the combined minimum of all the array's contents.
    var intersection: CGSize {
        return processWidthAndHeight(initial: .max, function: Swift.min)
    }
    
    private func processWidthAndHeight(initial: CGSize, function: (CGFloat, CGFloat) -> CGFloat) -> CGSize {
        return reduce(initial) { (result, size) -> CGSize in
            return CGSize(
                width: function(size.width, result.width),
                height: function(size.height, result.height)
            )
        }
    }
}

extension CGSize: AdditiveArithmetic {
    
    public static func + (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(
            width: left.width + right.width,
            height: left.height + right.height
        )
    }
    
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return lhs + -rhs
    }
    
    public static func += (lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs + rhs
    }
    
    public static func -= (lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs - rhs
    }
    
    public static prefix func - (value: CGSize) -> CGSize {
        return CGSize(width: -value.width, height: -value.height)
    }
}
