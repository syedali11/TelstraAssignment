//
//  APIServiceTests.swift
//  SwiftAssignmentTests
//
//  Created by Syed Tariq Ali on 01/06/21.
//

import XCTest
@testable import SwiftAssignment

class APIServiceTests: XCTestCase {
    
    var sut: APIHandler?

    override func setUp() {
        super.setUp()
        sut = APIHandler()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetch_JSON_data() {
        
        // Given An apiservice
        let sut = self.sut!
        
        // When fetch facts data
        let expect = XCTestExpectation(description: "callback")
        
        sut.getRows(complete: { _,_,_,error in
            XCTAssertNil(error, "Error should be nil")
            expect.fulfill()
            
        })
        wait(for: [expect], timeout: 30.0)
    }
    
    
    func test_FactsTitle() {

        // Given An apiservice
        let sut = self.sut!
        
        // When fetch facts data
        let expect = XCTestExpectation(description: "callback")
        
        sut.getRows(complete: { _,_,responseTitle,error in
            XCTAssertNotNil(responseTitle, "Title must not be nil.")
            expect.fulfill()
            
        })
        wait(for: [expect], timeout: 30.0)
    }
    
    func test_FactsRows() {
        // Given An apiservice
        let sut = self.sut!
        
        // When fetch facts data
        let expect = XCTestExpectation(description: "callback")
        
        sut.getRows(complete: { _,rows,_,error in
            XCTAssertNotNil(rows, "Rows must not be nil.")
            expect.fulfill()
            
        })
        wait(for: [expect], timeout: 30.0)
    }
}
