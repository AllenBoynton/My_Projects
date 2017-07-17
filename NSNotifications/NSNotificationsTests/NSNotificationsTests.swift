//
//  NSNotificationsTests.swift
//  NSNotificationsTests
//
//  Created by Allen Boynton on 7/12/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import XCTest
@testable import NSNotifications

class NSNotificationsTests: XCTestCase {
    
    func testSquareInt() {
        let value = 3
        let squaredValue = value.square()
        
        XCTAssertEqual(squaredValue, 9)
    }
    
    func testHelloWorld() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello world"
        XCTAssertEqual(helloWorld, "hello world")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
