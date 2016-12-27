//
//  RequestHandler.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/10/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation
import Alamofire

enum API {
  case weather
  case forecast
}

class RequestHelper {
  
  static let shared = RequestHelper()
  
  func getData(api: API, lat: Double, lon: Double, completed: @escaping ProcessingComplete) {
    switch api {
    case .weather:
      self.getWeatherData(lat: lat, lon: lon, completed: completed)
    case .forecast:
      self.getForecastData(lat: lat, lon: lon, completed: completed)
    }
  }
  
  private func getForecastData(lat: Double, lon: Double, completed: @escaping ProcessingComplete) {
    let latValue = LATITUDE + "\(lat)&"
    let lonValue = LONGITUDE + "\(lon)&"
    let keyValue = APP_ID + API_KEY
    let url = BASE_URL_FORECAST + latValue + lonValue + FORECAST_REST + keyValue
    
    self.fireRequest(url: url) { data in
      var forecast: GlobalWeatherProtocol?
      if let data = data {
        let parser = ForecastParser(data: data)
        forecast = parser.parse() 
      }
      completed(forecast)
    }
  }
  
  private func getWeatherData(lat: Double, lon: Double, completed: @escaping ProcessingComplete) {
    let latValue = LATITUDE + "\(lat)&"
    let lonValue = LONGITUDE + "\(lon)&"
    let keyValue = APP_ID + API_KEY
    let url = BASE_URL_WEATHER + latValue + lonValue + keyValue
    
    self.fireRequest(url: url) { data in
      var weather: WeatherProtocol?
      if let data = data {
        let parser = CurrentWeatherParser(data: data)
        weather = parser.parse()
      }
      completed(weather)
    }
  }
  
  private func fireRequest(url: String, completed: @escaping DownloadComplete) {
    var data: Data?
    Alamofire.request(url).responseJSON { response in
      if let responseData = response.data {
        print("JSON: \(response.result.value)")
        data = responseData
      }
      completed(data)
    }
  }
  
}
