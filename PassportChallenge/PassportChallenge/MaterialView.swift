//
//  MaterialView.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/14/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {
    
    @IBInspectable var materialDesign: Bool {
        
        get {
            return materialKey
        }
        set {
            materialKey = newValue
            
            if materialKey {
                
                self.layer.masksToBounds = true
                self.layer.cornerRadius = 10
                self.layer.shadowOpacity = 1.0
                self.layer.shadowRadius = 5
                self.layer.shadowOffset = CGSize(width: 4.0, height: 3.0)
                self.layer.shadowColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 0.9).cgColor
            } else {
                self.layer.cornerRadius = 5
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
}

