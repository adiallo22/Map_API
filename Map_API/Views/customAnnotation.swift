////
////  customAnnotation.swift
////  Map_API
////
////  Created by Abdul Diallo on 6/20/20.
////  Copyright © 2020 Abdul Diallo. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//class customAnnotation: MKAnnotationView {
//
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        collisionMode = .circle
//        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func prepareForDisplay() {
//        super.prepareForDisplay()
//        
//        if let cluster = annotation as? MKClusterAnnotation {
//            let total = cluster.memberAnnotations.count
//        }
//    }
//
//}
