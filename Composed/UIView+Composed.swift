//
//  UIView+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/4/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit

public extension UIView {
    func sizeThatFits(width: CGFloat) -> CGSize {
        return sizeThatFits(CGSize(
            width: width,
            height: .greatestFiniteMagnitude
        ))
    }
}
