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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.getWeatherForecastData()
  }
  
  func getWeatherForecastData() {
    var lat = 50.00
    var lon = 39.00
    //    var lat = 52.5243700 //Berlin
    //    var lon = 13.4105300 //Berlin
    if LocationHandler.shared.useUserLocation, let currentUserLocation = LocationHandler.shared.currentUserLocation {
      lat = currentUserLocation.latitude
      lon = currentUserLocation.longitude
    }
    
    if let selectedLocation = ApplicationData.shared.selectedLocation {
      lat = selectedLocation.latitude
      lon = selectedLocation.longitude
    }
    
    self.getCurrentWeatherData(lat: lat, lon: lon)
    self.getForecastData(lat: lat, lon: lon)
  }
  
  func getCurrentWeatherData(lat: Double, lon: Double) {
    RequestHelper.shared.getData(api: .weather, lat: lat, lon: lon) { object in
      if let weather = object as? Weather {
        LocationHandler.shared.addNewLocation(location: weather.location)
        self.currentWeatherView.updateUI(weather: weather)
      }
    }
  }
  
  func getForecastData(lat: Double, lon: Double) {
    RequestHelper.shared.getData(api: .forecast, lat: lat, lon: lon) { object in
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
  
  @IBAction func unwindToRoot(segue: UIStoryboardSegue) {
    //RELOAD THE DATA FOR PREVIOUS LOCATION
  }

}

