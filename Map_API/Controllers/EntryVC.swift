//
//  EntryVC.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/19/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

//protocol shareMatchingItems {
//    func passItems(matchingItems: [MKMapItem])
//}

class EntryVC: UIViewController {

    @IBOutlet weak var parameterButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    var matchingItems = [MKMapItem]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
//    var itemDelegate : shareMatchingItems?
    
    var selectedPin: MKPlacemark?
    
    var location : CLLocationCoordinate2D?
    
    var locationManager = CLLocationManager()
    
    var resultSearchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // register custom class
        map.register(CycleAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        //hides by default list and map buttons
        hideButtons()
        //delegation
        collectionView.delegate = self
        collectionView.dataSource = self
        map.delegate = self
        //create the uisearchcontroller to display a list of result
        let locSearch = storyboard?.instantiateViewController(identifier: Constants.IDs.locVC) as? SearchResultTVC
        resultSearchController = UISearchController(searchResultsController: locSearch)
        resultSearchController?.searchResultsUpdater = locSearch
        locSearch?.mapView = map
        locSearch?.handleMapSearchDelegate = self
        createSearchBar()
        
    }
        
    @IBAction func parameterClicked(_ sender: UIButton) {
        animateTheTransitionOfButtons()
    }
    
    @IBAction func listClicked(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.toList, sender: self)
    }
    
    @IBAction func mapClicked(_ sender: UIButton) {
        hideButtons()
        
    }
    
}


//MARK: - helpers


extension EntryVC {
    
    func startLocationservices() {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            map.showsUserLocation = true
        case .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            map.showsUserLocation = true
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func zoomClose(to coord: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: coord, latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.setRegion(region, animated: true)
    }
    
    func createSearchBar() {
        guard let bar = resultSearchController?.searchBar else { return }
        bar.sizeToFit()
        bar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
    }
    
    func dropPin(withPlacemark placemark: MKPlacemark) {
        let coordinate = placemark.coordinate
        let title = placemark.name
        let address = "\(placemark.subThoroughfare ?? "") \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.countryCode ?? "") -  \(placemark.postalCode ?? "")"
        let annotation = CustomPin.init(title: title!, subtitle: address, coordinate: coordinate)
        map.addAnnotation(annotation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.toList {
            let destVC = segue.destination as! ListVC
            destVC.matchItems = matchingItems
        }
        if segue.identifier == Constants.Segues.toPinDetails {
            guard let selectedItem = collectionView.indexPathsForSelectedItems?.first else { return }
            let destVC = segue.destination as! PinDetails
            destVC.pin = matchingItems[selectedItem.row]
        }
    }
    
    func hideButtons() {
        listButton.isHidden = true
        mapButton.isHidden = true
    }
    
    func animateTheTransitionOfButtons() {
        if listButton.isHidden && mapButton.isHidden {
            UIView.transition(with: listButton, duration: 0.6,
                              options: .transitionFlipFromBottom,
                animations: {
                    self.listButton.isHidden = false
            })
            UIView.transition(with: mapButton, duration: 0.6,
                              options: .transitionFlipFromRight,
                animations: {
                    self.mapButton.isHidden = false
            })
        } else {
            UIView.transition(with: listButton, duration: 0.6,
                              options: .transitionFlipFromTop,
                animations: {
                    self.listButton.isHidden = true
            })
            UIView.transition(with: mapButton, duration: 0.6,
                              options: .transitionFlipFromLeft,
                animations: {
                    self.mapButton.isHidden = true
            })
        }
    }
    
}



//MARK: - location manager



extension EntryVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            map.showsUserLocation = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        location = currentLocation.coordinate
        zoomClose(to: location!)
    }
    
}



//MARK: - HandleMapSearch



extension EntryVC : HandleMapSearch {
    
    func passAllLocs(withArray: [MKMapItem]) {
        matchingItems = withArray
        for item in withArray {
            let placemark = item.placemark
            dropPin(withPlacemark: placemark)
        }
    }
    
    func dropPinZoomIn(placemark:MKPlacemark) {
        matchingItems.removeAll()
        selectedPin = placemark
        map.removeAnnotations(map.annotations)
        dropPin(withPlacemark: placemark)
        zoomClose(to: placemark.coordinate)
    }
    
}



//MARK: - delegate and datasource



extension EntryVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.cell, for: indexPath) as! scrollCVC
        cell.title.text = "\(matchingItems[indexPath.row].name ?? "")"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segues.toPinDetails, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width / 3, height: 100)
    }
    
}


//MARK: - mkviewannotation


extension EntryVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = CycleAnnotationView(annotation: annotation, reuseIdentifier: CycleAnnotationView.ReuseID)
//        annotationView.canShowCallout = true
//        annotationView.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure)
        return annotationView
    }
    
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//    }
}


