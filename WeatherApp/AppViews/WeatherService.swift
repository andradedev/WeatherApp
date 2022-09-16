//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import SDKNetwork

class WeatherService: Service<WeatherAPI> {
    func getWeatherData(completion: @escaping (Result<WeatherModel, RequestError>) -> Void) {
        self.request(.weatherData(locationID: "4418"), model: WeatherModel.self) { result, _ in
            completion(result)
        }
    }
}
