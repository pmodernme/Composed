//
//  EdgeInsets+Composed.swift
//  
//
//  Created by Zoe Van Brunt on 12/19/22.
//

#if canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, visionOS 1.0, watchOS 6.0, *)
public extension EdgeInsets {
    
    init(square length: CGFloat) {
        self.init(top: length, leading: length, bottom: length, trailing: length)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    static var zero: EdgeInsets { EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) }
    
    var width: CGFloat { leading + trailing }
    var height: CGFloat { top + bottom }
}

#endif
