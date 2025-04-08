//
//  LazyUIBarItem.swift
//  Composed
//
//  Created by Zoe Van Brunt on 4/8/25.
//

#if canImport(UIKit)

import UIKit

extension UIBarItem: LazyFriendly { }

public extension LazyFriendly where Self: UIBarItem {
    
    func apply(_ modifier: (Self) -> Void) -> Self {
        modifier(self)
        return self
    }
    
}

#endif
