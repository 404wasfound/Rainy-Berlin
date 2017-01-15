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
  var cityName: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.getWeatherForecastData()
  }
  
  func getWeatherForecastData() {
    var tempLocationRU = Location(name: "Temporary Location RU", latitude: 50.00, longitude: 39.00)
//    var tempLocationBerlin = Location(name: "Temporary Location Berlin", latitude: 52.5243700, longitude: 13.4105300)
    if LocationHandler.shared.useUserLocation, let currentUserLocation = LocationHandler.shared.currentUserLocation {
      tempLocationRU = currentUserLocation
    }
    
    if let selectedLocation = ApplicationData.shared.selectedLocation {
      tempLocationRU = selectedLocation
    }
    
    self.getCurrentWeatherData(location: tempLocationRU)
    self.getForecastData(location: tempLocationRU)
  }
  
  func getCurrentWeatherData(location: Location) {
    RequestHelper.shared.getData(api: .weather, lat: location.latitude, lon: location.longitude) { object in
      if let weather = object as? Weather {
        LocationHandler.shared.addNewLocation(location: weather.location)
        self.currentWeatherView.updateUI(weather: weather)
      }
    }
  }
  
  func getForecastData(location: Location) {
    RequestHelper.shared.getData(api: .forecast, lat: location.latitude, lon: location.longitude) { object in
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

