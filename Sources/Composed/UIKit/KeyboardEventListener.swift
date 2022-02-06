//
//  KeyboardEventListener.swift
//  ZVBUIUtilities
//
//  Created by ZVB on 3/25/18.
//  Copyright © 2018 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public class KeyboardListener {
	public typealias KeyboardEventInfo =
		(beginFrame: CGRect?, endFrame: CGRect?,
		duration: TimeInterval?, curve: UIView.AnimationCurve?,
		localKeyboard: Bool?)

	private var willShow, didShow, willHide, didHide, willChange, didChange : ((KeyboardEventInfo) -> Void)?

	public init(operationQueue queue: OperationQueue = .main) {
        let center = NotificationCenter.default
        
        center.addObserver(
            self,
            selector: #selector(keyboardWillShow(note:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        center.addObserver(
            self,
            selector: #selector(keyboardDidShow(note:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
        
        center.addObserver(
            self,
            selector: #selector(keyboardWillHide(note:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        center.addObserver(
            self,
            selector: #selector(keyboardDidHide(note:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil)
        
        center.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(note:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
        
        center.addObserver(
            self,
            selector: #selector(keyboardDidChangeFrame(note:)),
            name: UIResponder.keyboardDidChangeFrameNotification,
            object: nil)
	}
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

	@objc private func keyboardWillShow(note: Notification) { willShow?(breakdown(note)) }
	@objc private func keyboardDidShow(note: Notification) { didShow?(breakdown(note)) }
	@objc private func keyboardWillHide(note: Notification) { willHide?(breakdown(note)) }
	@objc private func keyboardDidHide(note: Notification) { didHide?(breakdown(note)) }
	@objc private func keyboardWillChangeFrame(note: Notification) { willChange?(breakdown(note)) }
	@objc private func keyboardDidChangeFrame(note: Notification) { didChange?(breakdown(note)) }

	public func onWillShow(_ action: ((KeyboardEventInfo) -> Void)?) -> Self {
		willShow = action
		return self
	}
	public func onWillHide(_ action: ((KeyboardEventInfo) -> Void)?) -> Self {
		willHide = action
		return self
	}
	public func onDidShow(_ action: ((KeyboardEventInfo) -> Void)?) -> Self {
		didShow = action
		return self
	}
	public func onDidHide(_ action: ((KeyboardEventInfo) -> Void)?) -> Self {
		didHide = action
		return self
	}
	public func onWillChange(_ action: ((KeyboardEventInfo) -> Void)?) -> Self {
		willChange = action
		return self
	}
	public func onDidChange(_ action: ((KeyboardEventInfo) -> Void)?) -> Self {
		didChange = action
		return self
	}

	private func breakdown(_ note: Notification) -> KeyboardEventInfo {
		guard let info = note.userInfo else { return (nil, nil, nil, nil, nil) }
		let beginFrame = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
		let endFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
		let curve: UIView.AnimationCurve?
		if let curveNumber = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
			curve = UIView.AnimationCurve(rawValue: curveNumber.intValue)
		} else {
			curve = nil
		}
		let localKeyboard = (info[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber)?.boolValue

		return (beginFrame, endFrame, duration, curve, localKeyboard)
	}
}

public protocol AdjustsScrollViewForKeyboard {
    var keyboardListener: KeyboardListener? { get set }
}

public extension AdjustsScrollViewForKeyboard {
    func setupKeyboardListener(_ keyboardListener: inout KeyboardListener?, for scrollView: UIScrollView) {
        let action: (KeyboardListener.KeyboardEventInfo) -> Void = { [weak scrollView] event in
            guard let view = scrollView,
                let endFrame = event.endFrame
                else { return }
            
            let intersection = view.convert(endFrame, from: view.window)
                .intersection(view.bounds)
            
            if intersection == CGRect.null {
                view.contentInset.bottom = 0
            } else {
                view.contentInset.bottom = intersection.height
            }
        }
        
        keyboardListener = KeyboardListener(operationQueue: .main)
            .onWillShow(action)
            .onDidHide { event in UIView.animate(withDuration: 0.3) { action(event) }}
            .onDidChange { event in UIView.animate(withDuration: 0.3) { action(event) }}
    }
}

#endif
