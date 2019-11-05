//
//  CGRect+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import CoreGraphics

public extension CGRect {
    
    /// Returns the center of the `CGRect`.
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
