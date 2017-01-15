//
//  SearchCityVC.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 1/15/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class SearchCityVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var tableView: UITableView!
  
  var locations: [Location] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.searchBar.delegate = self
    
    if let savedLocations = ApplicationData.shared.favoriteLocations {
      self.locations = savedLocations
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchText = searchBar.text {
      if !searchText.isEmpty {
        let searchString = searchText.replacingOccurrences(of: " ", with: "")
        self.getCurrentWeatherDataForCity(name: searchString)
      }
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCell") as? SearchCityCell else {
      return UITableViewCell()
    }
    cell.configureCell(location: self.locations[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    ApplicationData.shared.selectedLocation = self.locations[indexPath.row]
    self.performSegue(withIdentifier: "unwindToRoot", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      self.locations.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      ApplicationData.shared.favoriteLocations = self.locations
      LocationHandler.shared.saveLocations()
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.locations.count
  }
  
  func getCurrentWeatherDataForCity(name: String) {
    RequestHelper.shared.getDataForCity(api: .weather, cityName: name) { object in
      if let weather = object as? Weather {
        LocationHandler.shared.addNewLocation(location: weather.location)
        ApplicationData.shared.selectedLocation = weather.location
        self.performSegue(withIdentifier: "unwindToRoot", sender: nil)
      }
    }
  }
  
}
