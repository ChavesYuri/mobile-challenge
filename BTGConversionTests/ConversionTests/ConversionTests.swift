//
//  ConversionTests.swift
//  BTGConversionTests
//
//  Created by Yuri Chaves on 22/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import XCTest
@testable import BTGConversion

class ConversionTests: XCTestCase {
    
    var viewModel: ConversionViewModel!

    override func setUpWithError() throws {
        viewModel = ConversionViewModel(coordinator: nil)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testRquestLive() throws{
        let promise = expectation(description: "No error in response")
        var responseError: Error?
        var sut: ConversionResponseModel?
        
        Services.conversionList { (result) in
            switch result{
            case .success(let itens):
                sut = itens
            case .failure(let error):
                responseError = error
            }
            promise.fulfill()
        }
        
        
        wait(for: [promise], timeout: 6)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(sut)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
