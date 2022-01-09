//
//  UIControl+Composed.swift
//  
//
//  Created by Zoe Van Brunt on 1/9/22.
//

#if canImport(UIKit)

import UIKit

public extension UIControl {
    
    final func withEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
}

#endif
