//
//  LazyFriendly.swift
//  Composed
//
//  Created by Zoe Van Brunt on 4/8/25.
//

public protocol LazyFriendly {
    func apply(_ modifier: (Self) -> Void) -> Self
}

extension LazyFriendly {
    public func apply(_ modifier: (Self) -> Void) -> Self {
        modifier(self)
        return self
    }
}
