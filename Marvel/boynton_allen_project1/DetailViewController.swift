//
//  DetailViewController.swift
//  Marvel
//
//  Created by Allen Boynton on 10/27/15.
//  Copyright © 2015 Allen Boynton. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentHero: ArrayInfo! = nil
    
    // IB Outlets to connect labels to label views
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var aliasLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Objects sent from Main Marvel VC
        navigationItem.title = currentHero.title
        aliasLabel.text! = currentHero.subtitle
        detailLabel.text! = currentHero.detail
        imageView.image = UIImage(named: currentHero.image)
    }
    
    // Created Action outlet to return to root controller
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
