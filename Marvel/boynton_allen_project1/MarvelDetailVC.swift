//
//  MarvelDetailVC.swift
//  Marvel
//
//  Created by Allen Boynton on 10/27/15.
//  Copyright © 2015 Allen Boynton. All rights reserved.
//

import UIKit

class MarvelDetailVC: UIViewController {
    
    var currentHero: ArrayInfo! = nil
    
    // IB Outlets to connect labels to label views
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var aliasLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Function to create the open variable to be viewed
        nameLabel.text! = currentHero!.title
        aliasLabel.text! = currentHero!.subtitle
        detailLabel.text! = currentHero!.detail
        imageView.image = UIImage(named: currentHero!.image)
    }
}
