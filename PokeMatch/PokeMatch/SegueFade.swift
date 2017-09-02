//
//  SegueFade.swift
//  PokéMatch
//
//  Created by Allen Boynton on 8/31/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import QuartzCore

class SegueFade: UIStoryboardSegue {
    
    override func perform() {
        let src: UIViewController = self.source
        let dst: UIViewController = self.destination
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.25
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFade
        src.view.layer.add(transition, forKey: kCATransition)
        src.present(dst, animated: true, completion: nil)
    }
}
