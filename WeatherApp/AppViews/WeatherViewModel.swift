//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import Foundation

protocol WeatherViewModelDelegate: ViewModelDelegate {
    func didLoadData(viewModel: WeatherViewModel, model: WeatherModel?)
}

class WeatherViewModel {
    weak var delegate: WeatherViewModelDelegate?
    var service = WeatherService()
    
    var model: WeatherModel?
    
    func getData() {
        delegate?.set(isLoading: true)
        service.getWeatherData { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.delegate?.set(isLoading: false)
                switch result {
                case .success(let model):
                    self.model = model
                    self.setLatestHour(model: model)
                case .failure(let error):
                    self.delegate?.setError(error)
                }
            }
        }
    }
    
    func setLatestHour(model: WeatherModel) {
        guard let firstData = model.consolidated_weather.first else { return }
        var finalWeatherData: WeatherModel.WeatherData = firstData
        
        for weatherData in model.consolidated_weather
            where stringToDate(date: finalWeatherData.created) < stringToDate(date: weatherData.created) {
            
            finalWeatherData = weatherData
        }
        
        var newModel = model
        newModel.latestData = finalWeatherData
        
        self.delegate?.didLoadData(viewModel: self, model: newModel)
    }
    
    func randomizeWhichValues() {
        var newModel = self.model
        newModel?.latestData = self.model?.consolidated_weather.randomElement()
        self.delegate?.didLoadData(viewModel: self, model: newModel)
    }
    
    func stringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: date) ?? Date(timeIntervalSince1970: .zero)
    }
}
