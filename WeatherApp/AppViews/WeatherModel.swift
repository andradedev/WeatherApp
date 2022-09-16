//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import Foundation

struct WeatherModel: Codable {
    let consolidated_weather: [WeatherData]
    let title: String
    let parent: Parent
    var latestData: WeatherData?
    
    struct WeatherData: Codable {
        let weather_state_name: String
        let weather_state_abbr: String
        let created: String
        let min_temp: Decimal
        let max_temp: Decimal
        let the_temp: Decimal
    }
    
    struct Parent: Codable {
        let title: String
    }
}
