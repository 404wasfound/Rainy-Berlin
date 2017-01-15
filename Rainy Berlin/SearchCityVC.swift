//
//  SearchCityVC.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 1/15/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class SearchCityVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var tableView: UITableView!
  
  var locations: [Location] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    if let savedLocations = ApplicationData.shared.favoriteLocations {
      self.locations = savedLocations
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
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.locations.count
  }
  
}
