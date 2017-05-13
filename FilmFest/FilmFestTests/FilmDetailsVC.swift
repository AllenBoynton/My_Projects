//
//  FilmDetailsVC.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/13/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import UIKit
import ChameleonFramework

class FilmDetailsVC: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GradientColor(.radial, frame: self.view.frame, colors: [UIColor.flatSkyBlue(), UIColor.flatNavyBlue()])
        
    }

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
