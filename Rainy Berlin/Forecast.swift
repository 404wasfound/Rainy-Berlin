//
//  Forecast.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/26/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation

struct WeatherObjectsList: GlobalWeatherProtocol {
  let weatherObjects: [WeatherProtocol]
}

struct Forecast: WeatherProtocol {
  let weatherType: String
  let highTemp: Double
  let lowTemp: Double
}

extension Forecast {
  var dateString: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    let currentDate = dateFormatter.string(from: Date())
    let dateString = "Today, \(currentDate)"
    return dateString
  }
}
