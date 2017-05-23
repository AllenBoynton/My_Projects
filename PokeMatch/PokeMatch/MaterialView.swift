//
//  MaterialView.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/23/17.
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
                
                self.layer.masksToBounds = false
               // self.layer.borderColor = UIColor.blue.cgColor
                self.layer.cornerRadius = 3
                self.layer.shadowOpacity = 1.0
                self.layer.shadowRadius = 3
                self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
                self.layer.shadowColor = UIColor(red: 104/255, green: 104/255, blue: 104/255, alpha: 1.0).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
}

