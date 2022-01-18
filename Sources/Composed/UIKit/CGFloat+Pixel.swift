//
//  CGFloat+Pixel.swift
//  
//
//  Created by Zoe Van Brunt on 1/18/22.
//

#if canImport(UIKit)

import UIKit

public extension CGFloat {
    static var pixel: CGFloat { 1 / UIScreen.main.scale }
}

#endif
