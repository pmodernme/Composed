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
    var result: CGRect = .zero
    var expected: CGRect = .zero
    
    override func setUp() {
        result = .zero
        expected = .zero
    }
    
    
    func testSizePlacement() {
        let size = CGSize(width: 100, height: 100)
        let point = CGPoint(x: 75, y: 75)
        
        result = size.setOrigin(point)
        expected = CGRect(x: 75, y: 75, width: 100, height: 100)
        XCTAssertEqual(result, expected)
        
        result = size.setCorner(.topLeft(point))
        XCTAssertEqual(result, expected)
        
        result = size.setCenter(point)
        expected = CGRect(x: 25, y: 25, width: 100, height: 100)
        XCTAssertEqual(result, expected)
        
        result = size.setCorner(.topRight(point))
        expected = CGRect(x: -25, y: 75, width: 100, height: 100)
        XCTAssertEqual(result, expected)
        
        result = size.setCorner(.bottomLeft(point))
        expected = CGRect(x: 75, y: -25, width: 100, height: 100)
        XCTAssertEqual(result, expected)
        
        result = size.setCorner(.bottomRight(point))
        expected = CGRect(x: -25, y: -25, width: 100, height: 100)
        XCTAssertEqual(result, expected)
    }
    
    func testCorner() {
        let size = CGSize(width: 100, height: 100)
        let point = CGPoint(x: 75, y: 75)
        
        result = Corner.topLeft(point).rectWithSize(size)
        expected = CGRect(x: 75, y: 75, width: 100, height: 100)
        XCTAssertEqual(result, expected)
        
        result = Corner.topRight(point).rectWithSize(size)
        expected = CGRect(x: -25, y: 75, width: 100, height: 100)
        XCTAssertEqual(result, expected)
        
        result = Corner.bottomLeft(point).rectWithSize(size)
        expected = CGRect(x: 75, y: -25, width: 100, height: 100)
        XCTAssertEqual(result, expected)
        
        result = Corner.bottomRight(point).rectWithSize(size)
        expected = CGRect(x: -25, y: -25, width: 100, height: 100)
        XCTAssertEqual(result, expected)
    }
    
    func testCorners() {
        let rect = CGRect(x: 75, y: 75, width: 100, height: 100)
        let corners = rect.corners
        
        XCTAssertEqual(corners.topLeft.point, CGPoint(x: 75, y: 75))
        XCTAssertEqual(corners.topRight.point, CGPoint(x: 175, y: 75))
        XCTAssertEqual(corners.bottomLeft.point, CGPoint(x: 75, y: 175))
        XCTAssertEqual(corners.bottomRight.point, CGPoint(x: 175, y: 175))
    }
    
    func testOffset() {
        let point = CGPoint(x: 50, y: 50)
        
        XCTAssertEqual(
            point.offset(by: CGPoint(x: 25, y: 25)),
            CGPoint(x: 75, y: 75)
        )
        
        XCTAssertEqual(
            point.offset(by: CGPoint(x: -25, y: -25)),
            CGPoint(x: 25, y: 25)
        )
        
        XCTAssertEqual(
            point.offset(by: CGPoint(x: -25, y: 25)),
            CGPoint(x: 25, y: 75)
        )
    }
    
    func testCenter() {
        let rect = CGRect(x: 50, y: 25, width: 200, height: 100)
        
        XCTAssertEqual(rect.center, CGPoint(x: 150, y: 75))
    }
    
    func testInsetSize() {
        let size = CGSize(width: 100, height: 50)
        
        XCTAssertEqual(
            size.insetBy(x: 10, y: 15),
            CGSize(width: 90, height: 35)
        )
        
        XCTAssertEqual(
            size.expandedBy(x: 10, y: 15),
            CGSize(width: 110, height: 65)
        )
    }
    
    func testSizeThatFits() {
        class TestView: UIView {
            override func sizeThatFits(_ size: CGSize) -> CGSize {
                return CGSize(
                    width: size.width,
                    height: min(size.height, 100)
                )
            }
        }
        
        let view = TestView()
        
        XCTAssertEqual(
            view.sizeThatFits(width: 500),
            CGSize(width: 500, height: 100)
        )
    }
}
