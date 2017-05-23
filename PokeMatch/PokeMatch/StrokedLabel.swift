//
//  StrokedLabel.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class StrokedLabel {
    
    // MARK: - Properties
    
    func draw(_ rect: CGRect) {
        
        do {
            let string: String = try "PokéMatch"
            var stringAttributes = [AnyHashable: Any]()
            
            // Define the font and fill color
            stringAttributes[NSFontAttributeName] = UIFont(name: "pokemon", size: CGFloat(32))
            stringAttributes[NSForegroundColorAttributeName] = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1.0)
            
            // Supply a negative value for stroke width that is 2% of the font point size in thickness
            stringAttributes[NSStrokeWidthAttributeName] = Int(-2.0)
            stringAttributes[NSStrokeColorAttributeName] = UIColor(red: 26/255, green: 59/255, blue: 148/255, alpha: 1.0).cgColor
            
            // Draw the string
            string.draw(at: CGSize(100, 100), withAttributes: stringAttributes)
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
}
