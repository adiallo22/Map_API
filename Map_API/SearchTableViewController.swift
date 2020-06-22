//
//  SearchTableViewController.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/18/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

class SearchTableViewController: UITableViewController {
    
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        

        return cell
    }

}

//MARK: - section heading

//extension SearchTableViewController : UISearchResultsUpdating {
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        print("okey")
//    }
//    
//}
