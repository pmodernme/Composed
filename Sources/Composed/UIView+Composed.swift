//
//  UIView+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/4/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Asks the view to calculate and return the size that best fits the
    /// specified `width` without concern for height.
    ///
    /// This method should not be overridden. It calls `sizeThatFits(:)`
    /// with a size that uses the `width` provided in the parameters and a
    /// height of `CGFloat.greatestFiniteMagnitude`. Override
    /// `sizeThatFits(_ size: CGSize)` instead.
    ///
    /// - Parameters:
    ///   - width: The `width` for which the view should calculate its
    ///   best-fitting size, without concern for height.
    ///
    /// - Returns:
    ///   A new size that fits the receiver's subviews.
    func sizeThatFits(width: CGFloat) -> CGSize {
        return sizeThatFits(CGSize(
            width: width,
            height: .greatestFiniteMagnitude
        ))
    }
}
