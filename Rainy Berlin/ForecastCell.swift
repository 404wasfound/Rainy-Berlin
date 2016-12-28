//
//  ForecastCell.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/27/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
  
  @IBOutlet weak var lowTemp: UILabel!
  @IBOutlet weak var highTemp: UILabel!
  @IBOutlet weak var weatherType: UILabel!
  @IBOutlet weak var dayOfWeek: UILabel!
  @IBOutlet weak var weatherTypeImge: UIImageView!
  
  func configureCell(forecast: Forecast) {
    self.lowTemp.text = "\(forecast.lowTemp)°"
    self.highTemp.text = "\(forecast.highTemp)°"
    self.weatherType.text = forecast.weatherType
    self.dayOfWeek.text = forecast.dateString
  }
  
}
