//
//  Constants.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/10/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation

let BASE_URL_WEATHER = "http://api.openweathermap.org/data/2.5/weather?"
let BASE_URL_FORECAST = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let FORECAST_REST = "cnt=8&mode=json&"
let LATITUDE = "lat="
let LONGITUDE = "lon="
let APP_ID = "appid="
let API_KEY = "31835cf6c23349b1a7689cf63945d341"

typealias ProcessingComplete = (_ weather: GlobalWeatherProtocol?) -> ()
typealias DownloadComplete = (_ data: Data?, _ error: NetworkError?) -> ()
