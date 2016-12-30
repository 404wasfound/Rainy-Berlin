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
  var latitude: Double?
  var longitude: Double?
  
}
