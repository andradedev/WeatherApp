//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Felipe Andrade on 16/09/22.
//

import XCTest
import SDKNetwork
@testable import WeatherApp

class WeatherServiceTests: XCTestCase {
    var service: WeatherService!
    var requester: MockRequester!
    
    override func setUp() {
        super.setUp()
        
        service = WeatherService()
        requester = MockRequester()
        service.requester = requester
    }

    func testWeatherRequestSucess() {
        let expectation = expectation(description: "weather request sucess test returned")
        requester.mockFile = "weatherData"
        
        service.getWeatherData { result in
            expectation.fulfill()
            switch result {
            case .success(let model):
                XCTAssertEqual(model.title, "Toronto")
                XCTAssertEqual(model.consolidated_weather.first?.weather_state_abbr, "lr")
                XCTAssertEqual(model.consolidated_weather.first?.created, "2021-09-13T22:16:21.961506Z")
                XCTAssertEqual(model.consolidated_weather.first?.weather_state_name, "Light Rain")
                XCTAssertEqual(model.consolidated_weather.first?.min_temp.toIntAsString(), "14")
                XCTAssertEqual(model.consolidated_weather.first?.max_temp.toIntAsString(), "22")
            case .failure:
                XCTFail("Weather request should not fail")
            }
        }
        waitForExpectations(timeout: 1)
    }
    
    func testWeatherRequestError() {
        let expectation = expectation(description: "weather request error test returned")
        requester.mockFile = "error"
        
        service.getWeatherData { result in
            expectation.fulfill()
            switch result {
            case .success:
                XCTFail("Weather request should not succeed")
            case .failure(let error):
                XCTAssertEqual(error.message, RequestError.parseError.message)
            }
        }
        waitForExpectations(timeout: 1)
    }
}

class MockRequester: Request {
    var mockFile: String?
    
    func makeRequest(_ service: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let file = Bundle(for: type(of: self)).path(forResource: mockFile, ofType: "json") else {
            XCTFail("No mock found")
            return
        }
        completion(try? String(contentsOfFile: file).data(using: .utf8), nil, nil)
    }
}
