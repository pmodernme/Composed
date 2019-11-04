//
//  CGSize+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit

public extension CGSize {
    func setOrigin(_ origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: self)
    }
    
    func setCenter(_ center: CGPoint) -> CGRect {
        return CGRect(
            x: center.x - width/2 ,
            y: center.y - height/2,
            width: width,
            height: height)
    }
    
    func insetBy(x: CGFloat, y: CGFloat) -> CGSize {
        return CGSize(width: width - x, height: height - y)
    }
    
    func expandedBy(x: CGFloat, y: CGFloat) -> CGSize {
        return insetBy(x: -x, y: -y)
    }
}
