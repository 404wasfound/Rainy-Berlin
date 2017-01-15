//
//  SplashScreenVC.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/28/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import UIKit
import CoreLocation

class SplashScreenVC: UIViewController, CLLocationManagerDelegate {
  
  var locationManager = CLLocationManager()
  var currentLocation: CLLocation!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startMonitoringSignificantLocationChanges()
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      if let currentLocation = manager.location {
        LocationHandler.shared.useUserLocation = true
        LocationHandler.shared.latitude = currentLocation.coordinate.latitude
        LocationHandler.shared.longitude = currentLocation.coordinate.longitude
      } else {
        print("THERE IS NO LOCATION. FAKING THE DATA...")
      }
      performSegue(withIdentifier: "showWeatherVC", sender: self)
    } else if status == .denied {
      performSegue(withIdentifier: "showWeatherVC", sender: self)
    } else if status == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    performSegue(withIdentifier: "showWeatherVC", sender: self) // Is not called if no internet. why?
  }

}
