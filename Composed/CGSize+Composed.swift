//
//  CGSize+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit

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
    
    /// Returns a `CGSize` by subtracting `x` and `y`
    /// from the receiver's `width` and `height` respectively.
    ///
    /// - Parameters:
    ///   - x: The value to subract from `width`
    ///   - y: The value to subtract from `height`
    func insetBy(x: CGFloat, y: CGFloat) -> CGSize {
        return CGSize(width: width - x, height: height - y)
    }
    
    /// Returns a `CGSize` by adding `x` and `y` to
    /// the receiver's `width` and `height` respectively.
    ///
    /// - Parameters:
    ///   - x: The value to add to `width`
    ///   - y: The value to add to `height`
    func expandedBy(x: CGFloat, y: CGFloat) -> CGSize {
        return insetBy(x: -x, y: -y)
    }
    
    /// The `CGSize` whose `width` and `height`
    /// are both `CGFloat.greatestFiniteMagnitude`
    static var max: CGSize {
        return CGSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
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
