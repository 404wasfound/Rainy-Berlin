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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 1
  }
  
  override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
    // something happens
  }
  
}
