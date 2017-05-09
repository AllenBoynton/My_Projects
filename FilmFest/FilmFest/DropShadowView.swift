//
//  DropShadowView.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/9/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import UIKit

@IBDesignable

class DropShadowView: UIView {

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowOpacity: Float = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    func setup() {
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }
}
