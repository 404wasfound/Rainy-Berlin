//
//  NetworkError.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 12/30/16.
//  Copyright © 2016 404wasfound. All rights reserved.
//

import Foundation

enum ErrorType: String {
  case connectionProblem = "Internet connection problem"
  case undefined         = "Undefined error"
}

struct NetworkError {
  var type: ErrorType
  var shouldUseFakeData: Bool
}
