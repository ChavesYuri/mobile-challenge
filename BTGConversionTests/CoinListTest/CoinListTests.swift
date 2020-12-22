//
//  CoinListTests.swift
//  BTGConversionTests
//
//  Created by Yuri Chaves on 22/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import XCTest
@testable import BTGConversion

class CoinListTests: XCTestCase {

    var viewModel: CoinListViewModel!

    override func setUpWithError() throws {
        viewModel = CoinListViewModel(coordinator: nil, type: .origin)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testRequestList() throws {
        let promise = expectation(description: "No error in response")
        var responseError: Error?
        var sut: CoinListResponseModel?
        
        Services.coinList{ (result) in
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
        XCTAssertEqual(sut?.success, true)
        sut = nil
        responseError = nil
    }

    
    func testReduceAndSorted(){
        let list = ["MXN":"Mexican Peso", "ARS":"Argentine Peso","ZWL":"Zimbabwean Dollar","BYR":"Bahamian Dollar", "AED":"United Arab Emirates Dirham"]
        viewModel.makeList(currencies: list)
        
        XCTAssertEqual(viewModel?.items.count, 5)
        XCTAssertEqual(viewModel?.items[0].initials, "AED")
    }
}
