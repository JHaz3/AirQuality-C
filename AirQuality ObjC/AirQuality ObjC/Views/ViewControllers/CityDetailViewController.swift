//
//  CityDetailViewController.swift
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {

    // MARK: - Properties
    var country: String?
    var state: String?
    var city: String?
    
    // MARK: - Outlets
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temeratureLabel: UILabel!
    @IBOutlet weak var humidityLevelLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var airQualityIndexLabel: UILabel!
    
    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city,
        let state = state,
        let country = country
        else { return }
        
        HAZCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityDetails) in
            if let details = cityDetails {
                self.updateViews(with: details)
            }
        }
        
    }
    
    // MARK: - Class Methods
    func updateViews(with details: HAZCityAirQuality) {
        DispatchQueue.main.async {
            self.countryLabel.text = details.country
            self.stateLabel.text = details.state
            self.cityLabel.text = details.city
            self.temeratureLabel.text = "\(details.weather.temperature)"
            self.humidityLevelLabel.text = "\(details.weather.humidity)"
            self.windSpeedLabel.text = "\(details.weather.windSpeed)"
            self.airQualityIndexLabel.text = "\(details.pollution.airQualityIndex)"
        }
    }

}
