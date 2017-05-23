//
//  StrokedLabel.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class StrokedLabel: UILabel {
    
    // MARK: - Properties
    
    var strokedText: String = "" {
        
        willSet(newValue) {
            
            let strokeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.blue,
                NSForegroundColorAttributeName : UIColor.white,
                NSStrokeWidthAttributeName : -4.0,
                NSFontAttributeName : UIFont.boldSystemFont(ofSize: 32)
                ] as [String : Any]
            
            let customizedText = NSMutableAttributedString(string: newValue,
                                                           attributes: strokeTextAttributes)
            
            attributedText = customizedText
        }
    }
}

//let text = "PokéMatch"

// UILabel subclass initialization
//let label = StrokedLabel(frame: CGRect(x: 0, y: 20, width: 375, height: 45))

// simple assign String to 'strokedText' property to see the results
//label.strokedText = text

//label.backgroundColor = UIColor.white

//label
