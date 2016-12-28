//
//  Forecast.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/26/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation

struct Forecast: WeatherProtocol {
  let weatherType: String
  let highTemp: Double
  let lowTemp: Double
  let dateDouble: Double
}

extension Forecast {
  var dateString: String {
    let date = Date(timeIntervalSince1970: dateDouble)
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    let currentDate = dateFormatter.string(from: Date())
    let dateToCompare = dateFormatter.string(from: date)
    if currentDate == dateToCompare {
      return "Today"
    }
    let dateStr = date.dayOfWeek()
    return dateStr
  }
}
