//
//  RoundedButtons.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/24/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class RoundedButtons: UIButton {
    
    // Creates rounded buttons for choice buttons
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0).cgColor
        self.clipsToBounds = true
    }
}
