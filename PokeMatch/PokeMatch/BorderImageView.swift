//
//  BorderImageView.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class BorderImageView: UIImageView {
    
    // Creates rounded image views for tiles
    override func awakeFromNib() {
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.clipsToBounds = true
    }
}
