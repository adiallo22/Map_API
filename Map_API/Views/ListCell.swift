//
//  ListCell.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

class ListCell: UICollectionViewCell {
    
    @IBOutlet weak var box1: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var pin : MKMapItem? {
        didSet {
            box1.boxTheView()
            guard let placemark = pin?.placemark else { return }
            name.text = placemark.name
            long.text = "\(String.init(format: "%4f", placemark.coordinate.longitude))"
            lat.text = "\(String.init(format: "%4f", placemark.coordinate.latitude))"
            address.text = "\(placemark.subThoroughfare ?? "") \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.countryCode ?? "") -  \(placemark.postalCode ?? "")"
        }
    }
    
    
}
