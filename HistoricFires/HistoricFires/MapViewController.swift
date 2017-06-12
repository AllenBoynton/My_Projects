//
//  MapViewController.swift
//  boynton_allen_project2
//
//  Created by Allen Boynton on 10/31/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
    
    // Created outlet for map view
    @IBOutlet weak var myMap: MKMapView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    var position: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 39.8, longitude: -95.0)
    
    // Loading properties to the super class
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup up initial zoom and view
        let span = MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60)
        let region = MKCoordinateRegionMake(position, span)
        
        myMap.region = region
        
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // Create pin annotation and titles on map view
    override func viewWillAppear(_ animated: Bool) {
        
        // Location and name arrays
        let city1: MKPointAnnotation = MKPointAnnotation()
            city1.coordinate = CLLocationCoordinate2D(latitude: 42.3499641, longitude: -71.0680552)
            city1.title = "\"The Great Fire At Boston\""
            city1.subtitle = "November 9, 1872 – November 10, 1872"
        
        let city2: MKPointAnnotation = MKPointAnnotation()
            city2.coordinate = CLLocationCoordinate2D(latitude: 37.84672, longitude: -122.37881)
            city2.title = "\"The Great San Francisco Earthquake\""
            city2.subtitle = "April 18, 1906, 5:12 AM"
        
        let city3: MKPointAnnotation = MKPointAnnotation()
            city3.coordinate = CLLocationCoordinate2D(latitude: 41.869002, longitude: -87.641501)
            city3.title = "\"The Great Chicago Fire\""
            city3.subtitle = "October 8, 1871 – October 10, 1871"
        
        // Add point annotations to my map
        myMap.addAnnotations([city1, city2, city3])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
