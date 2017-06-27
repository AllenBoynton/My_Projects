//
//  MarvelViewCell.swift
//  Marvel
//
//  Created by Allen Boynton on 10/28/15.
//  Copyright © 2015 Allen Boynton. All rights reserved.
//

import UIKit

class MarvelViewCell: UITableViewCell {
    
    // Create labels and images on table view
    @IBOutlet weak var heroLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    var heroData: ArrayInfo!
    
    func configureCell(_ heroData: ArrayInfo) {
        self.heroData = heroData
        
        heroImage.image = UIImage(named: "\(self.heroData.image)")
        heroLabel.text = self.heroData.title
        subLabel.text = self.heroData.subtitle
    }
}
