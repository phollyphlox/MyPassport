//
//  CountriesTableViewController.swift
//  MyPassport
//
//  Created by Phyllis Hollingshead on 2/6/15.
//  Copyright (c) 2015 Phyllis Hollingshead. All rights reserved.
//

import UIKit

var countries = ["Italy", "Norway", "England", "Spain"]

class CountriesTableViewController: UITableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return countries.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryIdentifer", for: indexPath) as  UITableViewCell
        
        let country = countries[indexPath.row]
        
        cell.textLabel!.text = country
        
        return cell
    }
    
}
