//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import UIKit
import SDKNetwork
import Kingfisher

class WeatherViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var skyLabel: UILabel!
    @IBOutlet weak var temperatureRangeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getData()
        setupNavigationButtons()
    }
    
    func setupNavigationButtons() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .refresh,
                                                              target: self,
                                                              action: #selector(reloadData)),
                                              UIBarButtonItem(image: UIImage(systemName: "dice"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(randomRecentValue))]
    }
    
    @objc func reloadData() {
        viewModel.getData()
    }
    
    @objc func randomRecentValue() {
        viewModel.randomizeWhichValues()
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func didLoadData(viewModel: WeatherViewModel, model: WeatherModel?) {
        guard let model = model else { return }

        titleLabel.text = "\(model.title) - \(model.parent.title)"
        let detailData = model.latestData
        temperatureLabel.text = detailData?.the_temp.toIntAsString()
        skyLabel.text = detailData?.weather_state_name
        
        guard let detailData = detailData else {
            temperatureRangeLabel.text = ""
            return
        }
        let imageURL = URL(string: WeatherAPI.image(abbr: detailData.weather_state_abbr).getFullURL())
        weatherIcon.kf.setImage(with: imageURL)
        temperatureRangeLabel
            .text = "L: \(detailData.min_temp.toIntAsString())° H: \(detailData.max_temp.toIntAsString())°"
    }
}
