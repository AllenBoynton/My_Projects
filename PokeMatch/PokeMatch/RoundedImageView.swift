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
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.white.cgColor //(red: 26/255, green: 59/255, blue: 148/255, alpha: 0.8).cgColor
        self.layer.borderWidth = 1.5
        self.clipsToBounds = true
    }
}
