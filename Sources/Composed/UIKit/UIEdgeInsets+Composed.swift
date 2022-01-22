//
//  UIEdgeInsets+Composed.swift
//  
//
//  Created by Zoe Van Brunt on 1/9/22.
//

#if canImport(UIKit)

import UIKit

public extension UIEdgeInsets {
    
    init(_ inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    var width: CGFloat { return left + right }
    
    var height: CGFloat { return top + bottom }
    
    var inverse: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}

extension UIEdgeInsets: AdditiveArithmetic {
    
    public static func + (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: left.top + right.top,
                            left: left.left + right.left,
                            bottom: left.bottom + right.bottom,
                            right: left.right + right.right)
    }
    
    public static func - (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        lhs + rhs.inverse
    }
    
    public static func += (lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs = lhs + rhs
    }
    
    public static func -= (lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs = lhs - rhs
    }
}

public extension CGRect {
    func expanded(by insets: UIEdgeInsets) -> CGRect {
        return inset(by: insets.inverse)
    }
}

public extension CGSize {
    func inset(by insets: UIEdgeInsets) -> CGSize {
        return CGSize(width: width - insets.width, height: height - insets.height)
    }
    
    func expanded(by insets: UIEdgeInsets) -> CGSize {
        return CGSize(width: width + insets.width, height: height + insets.height)
    }
}

#endif
