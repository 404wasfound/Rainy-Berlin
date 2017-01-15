//
//  LocationHandler.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/28/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation

class LocationHandler {
  
  static let shared = LocationHandler()
  
  var useUserLocation: Bool = false
  var currentUserLocation: Location?
  
  func addNewLocation(location: Location) {
    if let locations = ApplicationData.shared.favoriteLocations {
      if locations.contains(location) {
        print("Location is already saved")
        return
      } else {
        ApplicationData.shared.favoriteLocations?.append(location)
        self.saveLocations()
      }
    } else {
      ApplicationData.shared.favoriteLocations = [location]
      self.saveLocations()
    }
  }
  
  func readLocations() {
    if let savedData = UserDefaults.standard.object(forKey: "locations") as? Data {
      ApplicationData.shared.favoriteLocations = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? [Location]
    }
  }
  
  func saveLocations() {
    if let locationsToSave = ApplicationData.shared.favoriteLocations {
      let dataToSave = NSKeyedArchiver.archivedData(withRootObject: locationsToSave)
      UserDefaults.standard.set(dataToSave, forKey: "locations")
      UserDefaults.standard.synchronize()
    }
  }
  
}
