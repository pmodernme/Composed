//
//  CGSize+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit

public extension CGSize {
    func setOrigin(_ origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: self)
    }
    
    func setCenter(_ center: CGPoint) -> CGRect {
        return CGRect(
            x: center.x - width/2 ,
            y: center.y - height/2,
            width: width,
            height: height)
    }
    
    func insetBy(x: CGFloat, y: CGFloat) -> CGSize {
        return CGSize(width: width - x, height: height - y)
    }
    
    func expandedBy(x: CGFloat, y: CGFloat) -> CGSize {
        return insetBy(x: -x, y: -y)
    }
    
    static var max: CGSize {
        return CGSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )
    }
}

public func union(_ sizes: CGSize...) -> CGSize {
    return sizes.union
}

public func intersection(_ sizes: CGSize...) -> CGSize {
    return sizes.intersection
}

public extension Array where Element == CGSize {
    var union: CGSize {
        return processWidthAndHeight(for: self, initial: .zero, function: Swift.max)
    }
    
    var intersection: CGSize {
        return processWidthAndHeight(for: self, initial: .max, function: Swift.min)
    }
}

private func processWidthAndHeight(for sizes: [CGSize], initial: CGSize, function: (CGFloat, CGFloat) -> CGFloat) -> CGSize {
    return sizes.reduce(initial) { (result, size) -> CGSize in
        return CGSize(
            width: function(size.width, result.width),
            height: function(size.height, result.height)
        )
    }
}
