//
//  DetailViewController.swift
//  boynton_allen_project3
//
//  Created by Allen Boynton on 11/09/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDelegate {
    
    // Check that the array objects have value
    var currentPin: ArrayInfo? = nil
    
    let locationManager : CLLocationManager = CLLocationManager()
    
    // Created outlet for map view
    @IBOutlet weak var myMap: MKMapView!
    
    // Loading properties to the super class
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup up initial zoom and view
        let span = MKCoordinateSpan(latitudeDelta: 0.008000, longitudeDelta: 0.008000)
        let region = MKCoordinateRegionMake(currentPin!.location, span)
        
        myMap.region = region
        
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // Create pin annotation and titles on map view
    override func viewWillAppear(_ animated: Bool) {
        
        let pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = currentPin!.location
            pin.title = currentPin!.name
        
        self.title = currentPin!.name
        
        myMap.addAnnotation(pin)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
