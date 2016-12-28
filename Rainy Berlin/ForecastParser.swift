//
//  ForecastParser.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/26/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON

class ForecastParser: JsonParserProtocol {
  var jsonData: JSON = []

  func parse(data: Data) -> GlobalWeatherProtocol? {
    jsonData = JSON(data: data)
    if let newData = parseForecastList(json: self.jsonData) {
      return newData
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
    var dateDouble: Double?
    
    for (key, value) : (String, JSON) in json {
      switch key {
        case "dt":
          if let date = value.double {
            dateDouble = date
          }
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
    
    if let low = lowTemp, let high = highTemp, let type = weatherType, let date = dateDouble, self.checkDate(date: date) {
      let forecast = Forecast(weatherType: type, highTemp: high, lowTemp: low, dateDouble: date)
      return forecast
    }
    return nil
  }
  
  private func checkDate(date: Double) -> Bool {
    let currentDate = Date().timeIntervalSince1970
    if currentDate > date {
      return false
    }
    return true
  }

}
