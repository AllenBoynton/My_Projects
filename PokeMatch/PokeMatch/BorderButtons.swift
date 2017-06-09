//
//  BorderButtons.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/24/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class BorderButtons: UIButton {
    
    // Creates rounded buttons for choice buttons
    override func awakeFromNib() {
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.clipsToBounds = true
    }
}
