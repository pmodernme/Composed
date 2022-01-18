//
//  UILabel+Convenience.swift
//  ZoeLogIdeas
//
//  Created by Zoe Van Brunt on 11/24/21.
//

import UIKit

extension UILabel {
    var firstBaselineY: CGFloat { frame.origin.y + font.ascender }
    var ascenderLineY: CGFloat { frame.origin.y + font.ascender - font.capHeight }
}
