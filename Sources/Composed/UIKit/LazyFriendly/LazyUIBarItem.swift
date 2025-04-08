//
//  LazyUIBarItem.swift
//  Composed
//
//  Created by Zoe Van Brunt on 4/8/25.
//

#if canImport(UIKit)

import UIKit

extension LazyFriendly where Self: UIBarItem {
    
    func withTitle(_ title: String) -> Self {
        return apply { $0.title = title }
    }
    
    func withImage(_ image: UIImage) -> Self {
        return apply { $0.image = image }
    }
    
    func withLandscapeImagePhone(_ image: UIImage) -> Self {
        return apply { $0.landscapeImagePhone = image }
    }
    
    func withLargeContentSizeImage(_ image: UIImage) -> Self {
        return apply { $0.largeContentSizeImage = image }
    }
    
    func withImageInsets(_ insets: UIEdgeInsets) -> Self {
        return apply { $0.imageInsets = insets }
    }
    
    func withLandscapeImagePhoneInsets(_ insets: UIEdgeInsets) -> Self {
        return apply { $0.landscapeImagePhoneInsets = insets }
    }
    
    func withLargeContentSizeImageInsets(_ insets: UIEdgeInsets) -> Self {
        return apply { $0.largeContentSizeImageInsets = insets }
    }
    
    func withEnabled(_ enabled: Bool) -> Self {
        return apply { $0.isEnabled = enabled }
    }
    
    func withDisabled(_ disabled: Bool) -> Self {
        return withEnabled(!disabled)
    }
    
    func withTag(_ tag: Int) -> Self {
        return apply { $0.tag = tag }
    }
    
    func withTitleTextAttributes(
        _ attributes: [NSAttributedString.Key : Any]?,
        for state: UIControl.State
    ) -> Self {
        return apply {
            $0.setTitleTextAttributes(attributes, for: state)
        }
    }
    
}

extension LazyFriendly where Self: UIBarButtonItem {
    
    func withCustomView(_ view: UIView?) -> Self {
        return apply { $0.customView = view }
    }
    
    @available(iOS 14.0, tvOS 14.0, visionOS 1.0, *)
    func withPrimaryAction(_ action: UIAction?) -> Self {
        return apply { $0.primaryAction = action }
    }
    
    @available(iOS 14.0, tvOS 17.0, visionOS 1.0, *)
    func withMenu(_ menu: UIMenu?) -> Self {
        return apply { $0.menu = menu }
    }
    
}

#endif
