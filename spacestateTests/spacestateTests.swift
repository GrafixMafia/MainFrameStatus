//
//  spacestateTests.swift
//  spacestateTests
//
//  Created by markus on 23.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import UIKit
import XCTest

class spacestateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {

        var myStatus = StatusHandler()
        XCTAssert(myStatus.getStatus().length > 0, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            var myStatus = StatusHandler()
        }
    }
    
}
