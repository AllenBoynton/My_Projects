//
//  RoundedImageView.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    // Creates rounded image views for tiles
    override func awakeFromNib() {
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0).cgColor
        self.clipsToBounds = true
    }
}
