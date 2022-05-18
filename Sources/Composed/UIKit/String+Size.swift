//
//  String+Size.swift
//  
//
//  Created by Zoe Van Brunt on 5/18/22.
//


#if canImport(UIKit)

import UIKit

public extension String {
    func size(font: UIFont, width: CGFloat) -> CGSize {
        let str = self as NSString
        return str.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                options: [.usesLineFragmentOrigin],
                                attributes: [NSAttributedString.Key.font: font],
                                context: nil).size
    }
}

#endif
