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
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var aliasLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currentHero.title
    }
    
    // Function to create the open variable to be viewed
    override func viewWillAppear(_ animated: Bool) {
        
        // Function to create the open variable to be viewed
        aliasLabel.text! = currentHero!.subtitle
        detailLabel.text! = currentHero!.detail
        imageView.image = UIImage(named: currentHero!.image)
    }
    
    // Created Action outlet to return to root controller
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
