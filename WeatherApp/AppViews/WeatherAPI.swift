//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import SDKNetwork

enum WeatherAPI {
    case weatherData(locationID: String)
    case image(abbr: String)
}

extension WeatherAPI: ServiceRequest {
    var baseURL: String {
        "https://cdn.faire.com/static/mobile-take-home/"
    }
    
    var endpoint: String {
        switch self {
        case .weatherData(let locationID):
            return "\(locationID).json"
        case .image(let abbr):
            return "icons/\(abbr).png"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var data: DataTask.RequestContent {
        return .plain
    }
    
    func getFullURL() -> String {
        return "\(baseURL)\(endpoint)"
    }
}

