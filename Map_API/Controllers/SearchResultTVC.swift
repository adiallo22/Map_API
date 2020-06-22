//
//  SearchResultTVC.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/19/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
    func passAllLocs(withArray: [MKMapItem])
}



class SearchResultTVC: UITableViewController {
    
    var matchingItems : [MKMapItem] = [] {
        didSet {
            tableView.reloadData()
            handleMapSearchDelegate?.passAllLocs(withArray: matchingItems)
        }
    }
    
    var mapView: MKMapView?
    
    var handleMapSearchDelegate: HandleMapSearch?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! searchCell
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.item = selectedItem
        return cell
    }

}

//MARK: - <#section heading#>



extension SearchResultTVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let map = mapView, let searchBarText = searchController.searchBar.text else { return }
        //
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = map.region
        //
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
        }
    }
    
}
