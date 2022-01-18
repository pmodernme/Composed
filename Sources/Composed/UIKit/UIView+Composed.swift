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
}

public protocol LazyFriendly { }

public extension LazyFriendly where Self: UIView {
    
    func subview(of view: UIView) -> Self {
        view.addSubview(self)
        return self
    }
    
    func subview(of view: UIView, above subview: UIView? = nil) -> Self {
        return self.apply {
            if let subview = subview {
                view.insertSubview($0, aboveSubview: subview)
            } else {
                view.addSubview($0)
            }
        }
    }
    
    func subview(of view: UIView, below subview: UIView) -> Self {
        view.insertSubview(self, belowSubview: subview)
        return self
    }
    
    func withContentMode(_ contentMode: UIView.ContentMode) -> Self {
        return self.apply { $0.contentMode = contentMode }
    }
    
    func withAlpha(_ alpha: CGFloat) -> Self {
        return self.apply { $0.alpha = alpha }
    }
    
    func withHidden(_ isHidden: Bool) -> Self {
        return self.apply { $0.isHidden = isHidden }
    }
    
    func withVisible(_ visible: Bool) -> Self {
        return self.apply { $0.isHidden = !visible }
    }
    
    func withBackgroundColor(_ color: UIColor) -> Self {
        return self.apply { $0.backgroundColor = color }
    }
    
    func withCornerRadius(_ radius: CGFloat) -> Self {
        return self.apply { $0.layer.cornerRadius = radius }
    }
    
    func withTintColor(_ color: UIColor) -> Self {
        return self.apply { $0.tintColor = color }
    }
    
    func withClipsToBounds(_ clipsToBounds: Bool) -> Self {
        return self.apply { $0.clipsToBounds = clipsToBounds }
    }
    
    func apply(_ modifier: (Self) -> Void) -> Self {
        modifier(self)
        return self
    }
}

extension UIView: LazyFriendly { }

#endif
