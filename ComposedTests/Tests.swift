//
//  ComposedTests.swift
//  ComposedTests
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import XCTest
@testable import Composed

class Tests: XCTestCase {
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
            point.offsetBy(dx: 25, dy: 25),
            CGPoint(x: 75, y: 75)
        )
        
        XCTAssertEqual(
            point.offsetBy(dx: -25, dy: -25),
            CGPoint(x: 25, y: 25)
        )
        
        XCTAssertEqual(
            point.offsetBy(dx: -25, dy: 25),
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
            size.insetBy(dx: 5, dy: 10),
            CGSize(width: 90, height: 30)
        )
        
        XCTAssertEqual(
            size.expandedBy(dx: 10, dy: 15),
            CGSize(width: 120, height: 80)
        )
        
        XCTAssertEqual(
            size + CGSize(width: 5, height: 10),
            CGSize(width: 105, height: 60)
        )
        
        XCTAssertEqual(
            size - CGSize(width: 5, height: 10),
            CGSize(width: 95, height: 40)
        )
    }
    
    func testInOutArithmetic() {
        let originalSize = CGSize(width: 100, height: 50)
        let otherSize = CGSize(width: 5, height: 10)
        
        var size = originalSize
        
        size += otherSize
        XCTAssertEqual(size, CGSize(width: 105, height: 60))
        
        size = originalSize
        size -= otherSize
        XCTAssertEqual(size, CGSize(width: 95, height: 40))
        
        let originalPoint = CGPoint(x: 100, y: 50)
        let otherPoint = CGPoint(x: 5, y: 10)
        
        var point = originalPoint
        
        point += otherPoint
        XCTAssertEqual(point, CGPoint(x: 105, y: 60))
        
        point = originalPoint
        point -= otherPoint
        XCTAssertEqual(point, CGPoint(x: 95, y: 40))
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
    
    func testUnion() {
        XCTAssertEqual(
            union(
                CGSize(width: 100, height: 20),
                CGSize(width: 10, height: 150),
                CGSize(width: 2, height: 2),
                CGSize(width: 125, height: 1)
            ),
            CGSize(
                width: 125,
                height: 150)
        )
    }
    
    func testIntersection() {
        XCTAssertEqual(
            intersection(
                CGSize(width: 100, height: 20),
                CGSize(width: 10, height: 150),
                CGSize(width: 2, height: 2),
                CGSize(width: 125, height: 1)
            ),
            CGSize(
                width: 2,
                height: 1)
        )
    }
}
