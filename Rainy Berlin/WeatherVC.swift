//
//  WeatherVC.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/7/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var currentWeatherView: CurrentWeatherView!
  var forecasts = [Forecast]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.getCurrentWeatherData()
    self.getForecastData()
  }
  
  func getCurrentWeatherData() {
    let lat = 55.755826
    let lon = 37.617300
    let requestHelper = RequestHelper.shared
    requestHelper.getData(api: .weather, lat: lat, lon: lon) { object in
      if let weather = object as? Weather {
        self.currentWeatherView.updateUI(weather: weather)
      }
    }
  }
  
  func getForecastData() {
    let lat = 55.755826
    let lon = 37.617300
    let requestHelper = RequestHelper.shared
    requestHelper.getData(api: .forecast, lat: lat, lon: lon) { object in
      if let weatherObject = object as? WeatherObjectsList, let forecastsList = weatherObject.weatherObjects as? [Forecast] {
        self.forecasts = forecastsList
        self.tableView.reloadData()
      }
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.forecasts.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70.0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as? ForecastCell else {
      return UITableViewCell()
    }
    
    cell.configureCell(forecast: self.forecasts[indexPath.row])
    return cell
  }

}

