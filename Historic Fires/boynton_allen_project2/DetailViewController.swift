//
//  DetailViewController.swift
//  boynton_allen_project2
//
//  Created by Allen Boynton on 10/30/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentFire: ArrayInfo! = nil

    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myDetails: UILabel!
    @IBOutlet weak var fireImage: UIImageView!
    @IBOutlet weak var webAddress: UILabel!
//    @IBOutlet weak var refLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // Function to create the open variable to be viewed
    override func viewWillAppear(_ animated: Bool) {
        
        myTitle.text? = currentFire!.title
        myDetails.text! = currentFire!.article
        fireImage.image = UIImage(named: currentFire!.image)!
        webAddress.text! = currentFire!.link
//        refLabel.text? = currentFire!.references
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // Created back button to return to the main menu
    @IBAction func backButton2(_ segue: UIStoryboardSegue) {
        
    }
    
}
