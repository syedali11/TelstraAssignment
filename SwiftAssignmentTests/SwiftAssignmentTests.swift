//
//  SwiftAssignmentTests.swift
//  SwiftAssignmentTests
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import XCTest
@testable import SwiftAssignment

class SwiftAssignmentTests: XCTestCase {
    var sut: ViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ViewController()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func test_ViewController() {
        
        XCTAssertNotNil(sut, "ViewController must not be nil.")
        XCTAssertNotNil(sut?.view, "ViewController view must not be nil.")
        
        let subViews = sut?.view.subviews
        //let tableView = nil
        
        for subview in subViews! {
            if subview is UITableView {
                // this is a button
                XCTAssertNotNil(subview, "ViewController tableview must not be nil.")
            }
        }
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
