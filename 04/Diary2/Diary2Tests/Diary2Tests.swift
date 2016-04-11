//
//  Diary2Tests.swift
//  Diary2Tests
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import XCTest
@testable import Diary2

class Diary2Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDiaryInitialization() {
        // Success case.
        let newItem = Diary(title: "It's my title", text: "It'm my text", img: "2")
        XCTAssertNotNil(newItem)
        // Failure cases.
        let noTitle = Diary(title: "", text:"Everything fine", img: "0")
        XCTAssertNil(noTitle, "Empty title is invalid")
        let noText = Diary(title: "Really bad day", text:"", img: "1")
        XCTAssertNil(noText)
    }
    
}
