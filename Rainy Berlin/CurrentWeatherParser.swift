//
//  CurrentWeatherParser.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/26/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JsonParserProtocol {
  var jsonData: JSON { get set }
  func parse(data: Data) -> GlobalWeatherProtocol?
}

class CurrentWeatherParser: JsonParserProtocol {
  var jsonData: JSON = []
  
  func parse(data: Data) -> GlobalWeatherProtocol? {
    jsonData = JSON(data: data)
    if let newData = self.parsingWeather(json: self.jsonData) {
      return newData
    } else {
      return nil
    }
  }
  
  private func parsingWeather(json: JSON) -> Weather? {
    var currentTemperature: Double?
    var locationName: String?
    var weatherType: String?
    
    for (key, value) : (String, JSON) in json {
      switch key {
      case "main":
        for (key, value) : (String, JSON) in value {
          switch key {
          case "temp":
            if let temp = value.double {
              if temp > 100.0 {
                currentTemperature = temp - 273.15
                if let roundedTemp = currentTemperature {
                  currentTemperature = Double(round(roundedTemp*100)/100)
                }
              } else {
                currentTemperature = temp
              }
            }
          default: ()
          }
        }
      case "name":
        if let name = value.string {
          locationName = name
        }
      case "weather":
        if let weatherArray = value.array {
          if let newValue = weatherArray.first {
            for (key, value) : (String, JSON) in newValue {
              switch key {
              case "main":
                if let weather = value.string {
                  weatherType = weather
                }
              default: ()
              }
            }
          }
        }
      default: ()
      }
    }
    if let temp = currentTemperature, let name = locationName, let weather = weatherType {
      let weather = Weather(cityName: name, weatherType: weather, currentTemperature: temp)
      return weather
    }
    
    return nil
  }
  
}
