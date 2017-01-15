//
//  Weather.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/10/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import UIKit

protocol GlobalWeatherProtocol {
  //placeholder protocol used for bouding parsed objects
}

protocol WeatherProtocol: GlobalWeatherProtocol {
  var dateString: String { get }
}

struct WeatherObjectsList: GlobalWeatherProtocol {
  let weatherObjects: [WeatherProtocol]
}

struct Weather: WeatherProtocol {
  let cityName: String
  let weatherType: String
  let currentTemperature: Double
}

extension Weather {
  var dateString: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    let currentDate = dateFormatter.string(from: Date())
    let dateString = "Today, \(currentDate)"
    return dateString
  }
}
