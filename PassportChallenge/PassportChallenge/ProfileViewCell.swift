//
//  ProfileViewCell.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/13/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    
    // Create labels and images on table view
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iDLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    var profile: ProfileModel? {
        didSet {
            nameLabel.text = profile?.name
            iDLabel.text = profile?.idNum
            ageLabel.text = profile?.age
            genderLabel.text = profile?.gender
            profileImage.image = UIImage(named: (profile?.image)!)
        }
    }
}
