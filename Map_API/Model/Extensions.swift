//
//  Extensions.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

extension UIView {
    func boxTheView() {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
        self.layer.cornerRadius = 5
    }
}
