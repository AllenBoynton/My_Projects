//
//  ViewController.swift
//  NSNotifications
//
//  Created by Allen Boynton on 7/12/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pushNotification(_ sender: UIButton) {
        let alertView = UIAlertController(title: "You Won!", message: "Press 'Go' to continue", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Go", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
        
    }

}

