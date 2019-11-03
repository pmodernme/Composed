//
//  ComposedTests.swift
//  ComposedTests
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import XCTest
@testable import Composed

class ComposedTests: XCTestCase {
    func testSizePlacement() {
        var result: CGRect = .zero
        var expected: CGRect = .zero
        
        let size = CGSize(width: 100, height: 100)
        let point = CGPoint(x: 75, y: 75)
        
        result = size.atOrigin(point)
        expected = CGRect(x: 75, y: 75, width: 100, height: 100)
        
        XCTAssertEqual(result, expected)
        
        result = size.atCenter(point)
        expected = CGRect(x: 25, y: 25, width: 100, height: 100)
        
        XCTAssertEqual(result, expected)
    }
}
