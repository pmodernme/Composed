//
//  TextViewWithPlaceholder.swift
//  ZoeLog
//
//  Created by Zoe Van Brunt on 9/14/17.
//  Copyright © 2017 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit)

import UIKit

private let placeholderInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)

open class TextViewWithPlaceholder: UITextView {
    private lazy var placeholderLabel = UILabel()
        .withAlpha(0.25)
        .apply {
            $0.numberOfLines = 0
            $0.font = font
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(textDidUpdate(notification:)),
                name: UITextView.textDidChangeNotification,
                object: self)
        }
        .subview(of: self)
    
    public var placeholder: String? {
        set { placeholderLabel.text = newValue }
        get { return placeholderLabel.text }
    }
    
    open override var font: UIFont? {
        didSet { placeholderLabel.font = font }
    }
    
    open override var text: String! {
        didSet { textDidUpdate() }
    }
    
    @objc func textDidUpdate(notification note: Notification? = nil) {
//        placeholderLabel.isVisible = text.isEmpty
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let bounds = bounds
            .inset(by: textContainerInset)
            .inset(by: placeholderInsets)
        
        placeholderLabel.frame = placeholderLabel
            .sizeThatFits(bounds.size)
            .setOrigin(bounds.corners.topLeft.point)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let result = super.sizeThatFits(size)

        guard placeholderLabel.isVisible else { return result }
        
        let size = size
            .inset(by: textContainerInset)
            .inset(by: placeholderInsets)

        let placeholderSize = placeholderLabel
            .sizeThatFits(size)
            .expanded(by: textContainerInset)
            .expanded(by: placeholderInsets)

        return max(result, placeholderSize)
    }
}

#endif
