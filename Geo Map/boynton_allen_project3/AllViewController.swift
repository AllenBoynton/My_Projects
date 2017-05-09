//
//  AllViewController.swift
//  boynton_allen_project3
//
//  Created by Allen Boynton on 11/09/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//  Converted to Swift 3.0

import UIKit
import MapKit

class AllViewController: UIViewController {
    
    // Check that the array objects have value
    var currentPin: ArrayInfo? = nil
    
    // Created outlet for map view
    @IBOutlet weak var myMap2: MKMapView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    let position4: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 30.003985, longitude: -90.078278)
    // Loading properties to the super class
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup up initial zoom and view
        let span = MKCoordinateSpan(latitudeDelta: 70, longitudeDelta: 70)
        let region = MKCoordinateRegionMake(position4, span)
        
        myMap2.region = region
        
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // Create pin annotation and titles on map view
    override func viewWillAppear(_ animated: Bool) {
        
        // Location and name arrays
        let position : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 34.818577, longitude: -82.342529)
        let business1: MKPointAnnotation = MKPointAnnotation()
            business1.coordinate = position
            business1.title = "Al's Hobby Shop"
        
        let position2: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.669233, longitude: -70.027971)
        let business2: MKPointAnnotation = MKPointAnnotation()
            business2.coordinate = position2
            business2.title = "Bella's Books"
        
        let position3: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 25.772496, longitude: -80.132872)
        let business3: MKPointAnnotation = MKPointAnnotation()
            business3.coordinate = position3
            business3.title = "Cap Games"
        
        let business4: MKPointAnnotation = MKPointAnnotation()
            business4.coordinate = position4
            business4.title = "Dress Hut"
        
        let position5: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 36.182588, longitude: -115.146074)
        let business5: MKPointAnnotation = MKPointAnnotation()
            business5.title = "Energy Gym"
            business5.coordinate = position5
        
        let position6: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 42.168904, longitude: -82.827129)
        let business6: MKPointAnnotation = MKPointAnnotation()
            business6.title = "Frank's Nursery"
            business6.coordinate = position6
        
        let position7: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 46.799969, longitude: -100.773983)
        let business7: MKPointAnnotation = MKPointAnnotation()
            business7.title = "GB Photos"
            business7.coordinate = position7
        
        let position8: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 33.698333, longitude: -78.916168)
        let business8: MKPointAnnotation = MKPointAnnotation()
            business8.title = "Hunter's Magic Shop"
            business8.coordinate = position8
        
        let position9: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.756310, longitude: -73.982191)
        let business9: MKPointAnnotation = MKPointAnnotation()
            business9.title = "Kim's Wax Museum"
            business9.coordinate = position9
        
        let position10: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 47.609295, longitude: -122.335339)
        let business10: MKPointAnnotation = MKPointAnnotation()
            business10.title = "Mobile World"
            business10.coordinate = position10
        
        // Add point annotations to my map
        myMap2.addAnnotations([business1, business2, business3, business4, business5, business6, business7, business8, business9, business10])
        
    }
}
