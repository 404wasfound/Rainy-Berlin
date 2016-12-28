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
      currentLocation = locationManager.location
      LocationHandler.shared.latitude = currentLocation.coordinate.latitude
      LocationHandler.shared.longitude = currentLocation.coordinate.longitude
      performSegue(withIdentifier: "showWeatherVC", sender: self)
    } else if status == .denied {
      performSegue(withIdentifier: "showWeatherVC", sender: self)
    } else {
      locationManager.requestWhenInUseAuthorization()
    }
  }

}
