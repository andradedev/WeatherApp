//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Felipe Andrade on 16/09/22.
//

import XCTest
import SDKNetwork
@testable import WeatherApp

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var requester: MockRequester!
    
    enum DelegateCalled {
        case didLoadData(WeatherModel?)
        case setIsLoading(Bool)
        case setError
    }
    
    var completionBlock: ((DelegateCalled) -> Void)?
    
    override func setUp() {
        super.setUp()
        
        viewModel = WeatherViewModel()
        requester = MockRequester()
        viewModel.service.requester = requester
        viewModel.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        requester = nil
        completionBlock = nil
    }

    func testWeatherRequestSucess() {
        let expectationRequest = expectation(description: "weather request sucess test returned")
        let loadingStartedExpectation = expectation(description: "weather loading ON test returned")
        let loadingEndedExpectation = expectation(description: "weather loading OFF test returned")
        
        requester.mockFile = "weatherData"
        
        completionBlock = { delegate in
            switch delegate {
            case .didLoadData:
                expectationRequest.fulfill()
            case .setIsLoading(let isLoading):
                isLoading ? loadingStartedExpectation.fulfill() : loadingEndedExpectation.fulfill()
            case .setError:
                XCTFail("Weather request should not fail")
            }
        }
        viewModel.getData()
        
        waitForExpectations(timeout: 1)
    }
    
    func testWeatherRequestError() {
        let expectationRequest = expectation(description: "weather request error test returned")
        let loadingStartedExpectation = expectation(description: "weather loading ON test returned")
        let loadingEndedExpectation = expectation(description: "weather loading OFF test returned")
        
        requester.mockFile = "error"
        
        completionBlock = { delegate in
            switch delegate {
            case .didLoadData:
                XCTFail("Weather request should not succeed")
            case .setIsLoading(let isLoading):
                isLoading ? loadingStartedExpectation.fulfill() : loadingEndedExpectation.fulfill()
            case .setError:
                expectationRequest.fulfill()
            }
        }
        viewModel.getData()
        
        waitForExpectations(timeout: 1)
    }
    
    func testRandomizeValues() {
        let expectation = expectation(description: "test Randomize Values")
        
        let testModel = WeatherModel(consolidated_weather: [
            WeatherModel.WeatherData(weather_state_name: "unique value",
                                     weather_state_abbr: "un",
                                     created: "",
                                     min_temp: 1,
                                     max_temp: 1,
                                     the_temp: 1)
        ],
                                       title: "test",
                                       parent: .init(title: "test"))
        viewModel.model = testModel

        completionBlock = { delegate in
            expectation.fulfill()
            switch delegate {
            case .didLoadData(let model):
                XCTAssertEqual(model?.latestData?.weather_state_name,
                               testModel.consolidated_weather.first?.weather_state_name)
                XCTAssertEqual(model?.latestData?.weather_state_abbr,
                               testModel.consolidated_weather.first?.weather_state_abbr)
                XCTAssertEqual(model?.latestData?.the_temp,
                               testModel.consolidated_weather.first?.the_temp)
            default:
                XCTFail("Only didLoad data should be called")
            }
        }
        viewModel.randomizeWhichValues()
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStringToDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = viewModel.stringToDate(date: dateFormatter.string(from: Date()))
        XCTAssertLessThan(date.timeIntervalSince(Date()), 1)
    }
}

extension WeatherViewModelTests: WeatherViewModelDelegate {
    func didLoadData(viewModel: WeatherViewModel, model: WeatherModel?) {
        completionBlock?(.didLoadData(model))
    }
    
    func set(isLoading: Bool) {
        completionBlock?(.setIsLoading(isLoading))
    }
    
    func setError(_ error: RequestError) {
        completionBlock?(.setError)
    }
}
