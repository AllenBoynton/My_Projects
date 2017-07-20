//
//  InitialScreenVC.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth

class InitialScreenVC: UIViewController {
    
    // Outlets to move views when menu slides
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingScreenConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingScreenConstraint: NSLayoutConstraint!
    @IBOutlet weak var dismissMenuButton: UIButton!
    
    
    // Bool whether menu is open/closed
    var menuShowing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // Open faux menu
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        
        if menuShowing {
            leadingConstraint.constant = -225
            leadingScreenConstraint.constant = 0
            trailingScreenConstraint.constant = 0
            UIView.animate(withDuration: 0.4, animations: {
                self.dismissMenuButton.alpha = 0
                self.view.layoutIfNeeded()
            })
        } else {
            leadingConstraint.constant = 0
            leadingScreenConstraint.constant = 225
            trailingScreenConstraint.constant = -225
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.dismissMenuButton.alpha = 0.6
                self.view.layoutIfNeeded()
            })
        }
        
        // Allows toggle
        menuShowing = !menuShowing
    }
    
    // Dismiss the faux menu with blackedout background
    @IBAction func dismissMenuButton(_ sender: UIButton) {
        leadingConstraint.constant = -225
        leadingScreenConstraint.constant = 0
        trailingScreenConstraint.constant = 0
        
        UIView.animate(withDuration: 0.4, animations: {
            self.dismissMenuButton.alpha = 0
            self.view.layoutIfNeeded()
            
        })
    }
}
