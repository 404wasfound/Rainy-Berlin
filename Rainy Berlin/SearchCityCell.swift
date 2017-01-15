//
//  SearchCityCell.swift
//  Rainy Berlin
//
//  Created by Bogdan Yur on 1/15/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class SearchCityCell: UITableViewCell {

  @IBOutlet private weak var cityNameLabel: UILabel!
  
  func configureCell(location: Location) {
    self.cityNameLabel.text = location.name
  }

}
