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
    let latValue = LATITUDE + "\(lat)&"
    let lonValue = LONGITUDE + "\(lon)&"
    let keyValue = APP_ID + API_KEY
    var url: String
    var parser: JsonParserProtocol
    
    switch api {
    case .weather:
      url = BASE_URL_WEATHER + latValue + lonValue + keyValue
      parser = CurrentWeatherParser()
    case .forecast:
      url = BASE_URL_FORECAST + latValue + lonValue + FORECAST_REST + keyValue
      parser = ForecastParser()
    }
    self.getDataFromServer(url: url, parser: parser, completed: completed)
  }
  
  private func getDataFromServer(url: String, parser: JsonParserProtocol, completed: @escaping ProcessingComplete) {
    self.fireRequest(url: url) { data in
      var object: GlobalWeatherProtocol?
      if let data = data {
        object = parser.parse(data: data)
      }
      completed(object)
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
