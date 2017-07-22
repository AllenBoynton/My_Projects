//
//  DesignableLabels.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/17/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

@IBDesignable class DesignableLabels: UILabel {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = masksToBounds
        }
    }
}
