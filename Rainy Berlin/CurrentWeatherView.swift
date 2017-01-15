//
//  CurrentWeatherView.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/26/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var weatherImage: UIImageView!
  
  func updateUI(weather: Weather) {
    self.dateLabel.text = weather.dateString
    self.temperatureLabel.text = "\(weather.currentTemperature)°"
    self.locationLabel.text = weather.location.name
    self.weatherLabel.text = weather.weatherType
    self.weatherImage.image = UIImage(named: weather.weatherType)
  }
}
