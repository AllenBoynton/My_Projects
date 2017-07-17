//
//  ViewController.swift
//  NSNotifications
//
//  Created by Allen Boynton on 7/12/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        print(2.square())
    }
}

// Example used for Testing with XCTest
extension Int {
    func square() -> Int {
        return self * self
    }
}
