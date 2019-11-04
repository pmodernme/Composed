//
//  CGPoint+Composed.swift
//  Composed
//
//  Created by Zoe Van Brunt on 11/4/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit

public extension CGPoint {
    func offset(by offset: CGPoint) -> CGPoint {
        return CGPoint(
            x: x + offset.x,
            y: y + offset.y
        )
    }
}
