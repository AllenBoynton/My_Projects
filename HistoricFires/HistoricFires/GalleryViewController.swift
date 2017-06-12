//
//  GalleryViewController.swift
//  boynton_allen_project2
//
//  Created by Allen Boynton on 10/30/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit
import MapKit

class GalleryViewController: UIViewController {
    
    var fireGallery: ArrayInfo! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create city pin information
        let fire1: ArrayInfo = ArrayInfo()
            fire1.city = "The Great Fire At Boston"
            fire1.image = "Boston.jpg"
            fire1.details1 = "Boston’s fire was arguably the most expensive in terms of property damage of any American fire."
            fire1.image = "Boston2.jpg"
            fire1.details2 = "Most of the damage was confined to the cities’ downtown areas and financial districts, resulting in thousands of Bostonians losing their jobs and hundreds of businesses being destroyed."
        
        let fire2: ArrayInfo = ArrayInfo()
            fire2.city = "The Great San Francisco Earthquake"
            fire2.image = "San_Francisco.jpg"
            fire2.details1 = "The fire that burned 25,000 buildings over 490 city blocks and left some 3,000 dead."
            fire2.image = "San-Francisco2.jpg"
            fire2.details2 = "The fire was a by-product of a massive earthquake that hit the city in the predawn hours of April 18, 1906."
        
        let fire3: ArrayInfo = ArrayInfo()
            fire3.city = "The Great Chicago Fire"
            fire3.image = "Chicago1.jpg"
            fire3.details1 = "Probably few infernos have been as famous as the one that ravaged much of Chicago in October, 1871, leaving more that 17,000 structures burned and 90,000 people homeless."
            fire3.image = "Chicago2.jpg"
            fire3.details2 = "The fire paved the way for a new and improved Chicago to rise from the ashes that would within a few short decades make it the great metropolis it is today."
        
        // Pass in the locations into the storyboard
        dataArray.append(fire1)
        dataArray.append(fire2)
        dataArray.append(fire3)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // Created back button to return to the main menu
    @IBAction func backButton2(_ segue: UIStoryboardSegue) {
        
    }

}
