//
//  UIView+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/4/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public extension UIView {
    
    var isVisible: Bool {
        set { isHidden = !newValue }
        get { !isHidden }
    }
    
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
    final func sizeThatFits(width: CGFloat) -> CGSize {
        return sizeThatFits(CGSize(
            width: width,
            height: .greatestFiniteMagnitude
        ))
    }
    
    final func sizeThatFits(height: CGFloat) -> CGSize {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: height))
    }
    
    final func heightFor(width: CGFloat) -> CGFloat {
        return sizeThatFits(width: width).height
    }
    
    final func subview(of view: UIView, above subview: UIView? = nil) -> Self {
        return self.withModifier {
            if let subview = subview {
                view.insertSubview($0, aboveSubview: subview)
            } else {
                view.addSubview($0)
            }
        }
    }
    
    final func withContentMode(_ contentMode: UIView.ContentMode) -> Self {
        return self.withModifier { $0.contentMode = contentMode }
    }
    
    final func withAlpha(_ alpha: CGFloat) -> Self {
        return self.withModifier { $0.alpha = alpha }
    }
    
    final func withHidden(_ isHidden: Bool) -> Self {
        return self.withModifier { $0.isHidden = isHidden }
    }
    
    final func withVisible(_ visible: Bool) -> Self {
        return self.withModifier { $0.isHidden = !visible }
    }
    
    final func withBackgroundColor(_ color: UIColor) -> Self {
        return self.withModifier { $0.backgroundColor = color }
    }
    
    final func withCornerRadius(_ radius: CGFloat) -> Self {
        return self.withModifier { $0.layer.cornerRadius = radius }
    }
    
    final func withTintColor(_ color: UIColor) -> Self {
        return self.withModifier { $0.tintColor = color }
    }
    
    final func withClipsToBounds(_ clipsToBounds: Bool) -> Self {
        return self.withModifier { $0.clipsToBounds = clipsToBounds }
    }
    
    internal func withModifier(_ modifier: (Self) -> Void) -> Self {
        modifier(self)
        return self
    }
}

#endif
