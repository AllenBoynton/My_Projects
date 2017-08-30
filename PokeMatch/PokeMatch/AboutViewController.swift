//
//  AboutViewController.swift
//  PokéMatch
//
//  Created by Allen Boynton on 7/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class AboutViewController: UIViewController {
    
    let mainMenuVC = MainMenuViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuVC.facebookLikeButton()
    }
    
    // Dismiss VC
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
