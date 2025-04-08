//
//  LazyUIView.swift
//  Composed
//
//  Created by Zoe Van Brunt on 4/8/25.
//

#if canImport(UIKit)

import UIKit

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
}

#endif
