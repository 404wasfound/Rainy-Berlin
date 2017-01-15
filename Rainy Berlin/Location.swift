//
//  Location.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 1/15/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class Location: NSObject, NSCoding {
  
  var name: String
  var latitude: Double
  var longitude: Double
  
  init(name: String, latitude: Double, longitude: Double) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "locationName")
    aCoder.encode(self.latitude, forKey: "locationLatitude")
    aCoder.encode(self.longitude, forKey: "locationLongitude")
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: "locationName") as! String
    self.latitude = aDecoder.decodeDouble(forKey: "locationLatitude")
    self.longitude = aDecoder.decodeDouble(forKey: "locationLongitude")
  }
  
  static func ==(lhs: Location, rhs: Location) -> Bool {
    if lhs.latitude == rhs.latitude, lhs.longitude == rhs.longitude {
      return true
    } else {
      return false
    }
  }
  
}
