//
//  DecimalExtensionTests.swift
//  WeatherAppTests
//
//  Created by Felipe Andrade on 16/09/22.
//

import XCTest
@testable import WeatherApp

class DecimalExtensionTests: XCTestCase {
    func testToNearestInt() {
        let greater: Decimal = 1.1
        let smaller: Decimal = 0.9
        
        XCTAssertEqual(greater.toNearestInt(), smaller.toNearestInt())
    }
    
    func testToNearestIntAsString() {
        let greater: Decimal = 1.1
        let smaller: Decimal = 0.9
        
        XCTAssertEqual(greater.toIntAsString(), smaller.toIntAsString())
    }
}
