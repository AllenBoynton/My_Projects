//
//  MainViewController.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/8/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import UIKit
import ChameleonFramework

class MainViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = GradientColor(.radial, frame: self.view.frame, colors: [UIColor.flatSkyBlue(), UIColor.flatNavyBlue()])
    }

}

