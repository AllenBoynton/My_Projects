//
//  WinnersVC.swift
//  PokéMatch
//
//  Created by Allen Boynton on 6/10/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class WinnersVC: UIViewController {
    
    @IBOutlet weak var finalGamePoints: UILabel!
    @IBOutlet weak var finalGameTime: UILabel!
    
    
    // Images passed from OptionsVC
    var pointsPassed = ""
    var timePassed = ""

    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Assign value to labels
        finalGamePoints.text = pointsPassed
        finalGameTime.text = timePassed
        

    }


}
