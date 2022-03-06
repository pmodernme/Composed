//
//  UITextRange+Convenience.swift
//  ZVBUIUtilities
//
//  Created by ZVB on 4/29/18.
//  Copyright © 2018 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public extension UITextRange {
	func asRange(in textInput: UITextInput) -> NSRange? {
		let beginning = textInput.beginningOfDocument
		let location = textInput.offset(from: beginning, to: start)
		let offset = textInput.offset(from: start, to: end)
		return NSMakeRange(location, offset)
	}
}

public extension UITextInput {
	var selectedRange: NSRange? {
		guard let selection = selectedTextRange else { return nil }
		return selection.asRange(in: self)
	}

	func textRange(with range: NSRange) -> UITextRange? {
		guard let start = position(from: beginningOfDocument, offset: range.location),
			let end = position(from: start, offset: range.length)
			else { return nil }
		return textRange(from: start, to: end)
	}
    
    var documentRange: UITextRange? {
        return textRange(from: beginningOfDocument, to: endOfDocument)
    }
    
    var text: String? {
        get {
            guard let range = documentRange else { return nil }
            return text(in: range)
        }
        set {
            let text = newValue ?? ""
            guard let documentRange = documentRange else { return }
            replace(documentRange, withText: text)
        }
    }
}

#endif
