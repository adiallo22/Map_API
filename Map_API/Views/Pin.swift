//
//  Pin.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

class Pin: NSObject, MKAnnotation {
    
    var name : String?
    var address : String?
    var coordinate : CLLocationCoordinate2D
    
    init(name: String, address: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
    }

}
