//
//  PinDetails.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/19/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

class PinDetails: UIViewController {
    
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var coordinatestf: UILabel!
    @IBOutlet weak var addresstf: UILabel!
    
    var pin : MKMapItem?

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.setNavigationBarHidden(true, animated: true)
        setLocDetails()
        box.boxTheView()
        
    }
    
    @IBAction func navigatePressed(_ sender: UIButton) {
        openMapForPlace()
    }
    
}

//MARK: - helpers

extension PinDetails {
    
    func setLocDetails() {
        guard let pin = pin else { return }
        name.text = pin.name
        let coordinates = "Lon: \(String.init(format: "%3f", pin.placemark.coordinate.longitude)), Lat:  \(String.init(format: "%3f", pin.placemark.coordinate.latitude))"
        coordinatestf.text = coordinates
        let address = "\(pin.placemark.subThoroughfare ?? "") \(pin.placemark.locality ?? ""), \(pin.placemark.administrativeArea ?? "") \(pin.placemark.countryCode ?? "") -  \(pin.placemark.postalCode ?? "")"
        addresstf.text = address
    }
    
    func openMapForPlace() {
        guard let item = pin else { return }
        let coord = item.placemark.coordinate
        let regionSpan = MKCoordinateRegion.init(center: coord, latitudinalMeters: 10_000, longitudinalMeters: 10_000)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        item.openInMaps(launchOptions: options)
    }
    
}
