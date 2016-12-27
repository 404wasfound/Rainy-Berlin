//
//  ForecastParser.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/26/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON

class ForecastParser {
  
  let jsonData: JSON
  init(data: Data) {
    self.jsonData = JSON(data: data)
  }
  
  func parse() -> WeatherObjectsList? {
    if let data = parseForecastList(json: self.jsonData) {
      return data
    } else {
      return nil
    }
  }
  
  private func parseForecastList(json: JSON) -> WeatherObjectsList? {
    
    var forecasts: WeatherObjectsList?
    var forecastsArray: [Forecast] = []
    if let listArray = json["list"].array {
      for forecastRaw in listArray {
        if let forecast = self.parseForecast(json: forecastRaw) {
          forecastsArray.append(forecast)
        }
      }
      forecasts = WeatherObjectsList(weatherObjects: forecastsArray)
    }
    
    return forecasts
  }
  
  private func parseForecast(json: JSON) -> Forecast? {
    
    var lowTemp: Double?
    var highTemp: Double?
    var weatherType: String?
    
    for (key, value) : (String, JSON) in json {
      switch key {
        case "temp":
          for (key, value) : (String, JSON) in value {
            switch key {
            case "min":
              if let min = value.double {
                if min > 100 {
                  lowTemp = min - 273.15
                  if let low = lowTemp {
                    lowTemp = Double(round(low*10)/10)
                  }
                } else {
                  lowTemp = min
                }
              }
            case "max":
              if let max = value.double {
                if max > 100 {
                  highTemp = max - 273.15
                  if let high = highTemp {
                    highTemp = Double(round(high*10)/10)
                  }
                } else {
                  highTemp = max
                }
              }
            default: ()
            }
        }
        case "weather":
          if let weatherArray = value.array {
            if let newValue = weatherArray.first {
              for (key, value) : (String, JSON) in newValue {
                switch key {
                  case "main":
                    weatherType = value.string
                default: ()
                }
              }
            }
        }
      default: ()
      }
    }
    
    if let low = lowTemp, let high = highTemp, let type = weatherType {
      let forecast = Forecast(weatherType: type, highTemp: high, lowTemp: low)
      return forecast
    }
    
    return nil
  }
  
}
