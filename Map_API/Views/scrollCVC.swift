//
//  scrollCVC.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/19/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class scrollCVC: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.layer.frame.width / 2.0
    }

    
}
