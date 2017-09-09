//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Allen Boynton on 9/8/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let zoomImageView = UIImageView()
    let startingFrame = CGRect(x: 0, y: 20, width: 200, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomImageView.frame = startingFrame
        zoomImageView.backgroundColor = UIColor.red
        zoomImageView.image = UIImage(named: "allen_feed")
        zoomImageView.contentMode = .scaleAspectFill
        zoomImageView.clipsToBounds = true
        zoomImageView.isUserInteractionEnabled = true
        
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.animate)))
        
        view.addSubview(zoomImageView)
    }
    
    func animate() {
        UIView.animate(withDuration: 0.75) { () -> Void in
                let height = (self.view.frame.width / self.startingFrame.width) * self.startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.view.backgroundColor = UIColor.black
            
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
        }
    }
}

