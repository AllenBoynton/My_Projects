//
//  DetailViewController.swift
//  Boynton_Allen_project1
//
//  Created by Allen Boynton on 10/2/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentCharacter: ArrayInfo! = nil
    
    // IB Outlets to connect labels to label views
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
        
    // Loading properties to the super class
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currentCharacter!.actor
        
    }
    
    // Function to create the open variable to be viewed
    override func viewWillAppear(_ animated: Bool) {
            
        firstLabel.text! = currentCharacter!.character
        secondLabel.text! = currentCharacter!.description
        
        imageView.image! = UIImage(named:currentCharacter!.image)!
    }
    
    // Created back button to return to the main menu
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
