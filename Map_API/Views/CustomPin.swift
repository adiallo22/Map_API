//
//  CustomPin.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/21/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation {
    
    var title : String?
    var subtitle : String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
