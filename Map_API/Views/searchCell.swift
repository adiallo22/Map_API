//
//  searchCell.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/19/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

class searchCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var item : MKPlacemark! {
        didSet {
            titleLabel.text = item.name
            addressLabel.text = "\(item.subThoroughfare ?? "") \(item.locality ?? ""), \(item.administrativeArea ?? "") \(item.countryCode ?? "") -  \(item.postalCode ?? "")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
