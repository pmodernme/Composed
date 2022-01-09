//
//  KeyboardBackgroundView.swift
//  ZVBUIUtilities
//
//  Created by ZVB on 4/30/18.
//  Copyright © 2018 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public class KeyboardBackgroundView: UIView {
    
    private var blurEffect: UIBlurEffect {
        let style: UIBlurEffect.Style = {
            if #available(iOS 13, *) {
                return .systemChromeMaterial
            } else if #available(iOS 10.0, *) {
                return .regular
            } else {
                return .light
            }
        }()
        return UIBlurEffect(style: style)
    }
    
	lazy var blur = UIVisualEffectView(effect: blurEffect)
        .subview(of: self)
    
    lazy var tone = UIView()
        .withBackgroundColor(
            UIColor(red: 0.921569, green: 0.941176, blue: 0.968627, alpha: 0.9))
        .withHidden(isDarkMode)
        .subview(of: self, above: blur)

	lazy var grey = UIView()
        .withBackgroundColor(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))
        .withAlpha(0.24)
        .withHidden(isDarkMode)
        .subview(of: self, above: tone)

	public override func layoutSubviews() {
		super.layoutSubviews()

		let bounds = bounds
            .expanded(by: UIEdgeInsets(horizontal: 0, vertical: 40))
		blur.frame = bounds
		tone.frame = bounds
		grey.frame = bounds
	}
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        blur.effect = blurEffect
        tone.isHidden = isDarkMode
        grey.isHidden = isDarkMode
    }
    
    private var isDarkMode: Bool {
        if #available(iOS 12.0, *) {
            return traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
}

#endif
