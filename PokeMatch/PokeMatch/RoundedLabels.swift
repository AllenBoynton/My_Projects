//
//  RoundedLabels.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class RoundedLabels: UILabel {
    
    // Creates rounded buttons for choice buttons
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1.0).cgColor
        self.layer.masksToBounds = true
    }
}
