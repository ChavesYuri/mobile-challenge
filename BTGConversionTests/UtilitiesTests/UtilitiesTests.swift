//
//  UtilitiesTests.swift
//  BTGConversionTests
//
//  Created by Yuri Chaves on 22/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import XCTest
@testable import BTGConversion

class UtilitiesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringToDouble(){
        let value1 = "13,00"
        let value2 = "14.00"
        let value3 = "R$ 20.0"
        let value4 = "10"
        let value5 = ""
        XCTAssertEqual(LayoutHelper.stringToDecimal(string: value1), NSNumber(value: 13.0))
        XCTAssertEqual(LayoutHelper.stringToDecimal(string: value2), NSNumber(value: 14.0))
        XCTAssertEqual(LayoutHelper.stringToDecimal(string: value3), NSNumber(value: 20.0))
        XCTAssertEqual(LayoutHelper.stringToDecimal(string: value4), NSNumber(value: 10.0))
        XCTAssertEqual(LayoutHelper.stringToDecimal(string: value5), nil)
        
    }

}
