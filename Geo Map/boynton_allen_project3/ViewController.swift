//
//  ViewController.swift
//  boynton_allen_project3
//
//  Created by Allen Boynton on 11/09/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Local variables
    var dataArray: [ArrayInfo] = []
    
    // Check that the array objects have value
    var currentPin: ArrayInfo? = nil
    
    // Outlet to add table view to the view controller
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create business pin information
        let business1: ArrayInfo = ArrayInfo()
            business1.name = "Al's Hobby Shop"
            business1.location = CLLocationCoordinate2D(latitude: 34.818577, longitude: -82.342529)
        
        let business2: ArrayInfo = ArrayInfo()
            business2.name = "Bella's Books"
            business2.location = CLLocationCoordinate2D(latitude: 41.669233, longitude: -70.027971)
        
        let business3: ArrayInfo = ArrayInfo()
            business3.name = "Cap Games"
            business3.location = CLLocationCoordinate2D(latitude: 25.772496, longitude: -80.132872)
        
        let business4: ArrayInfo = ArrayInfo()
            business4.name = "Dress Hut"
            business4.location = CLLocationCoordinate2D(latitude: 30.003985, longitude: -90.078278)
        
        let business5: ArrayInfo = ArrayInfo()
            business5.name = "Energy Gym"
            business5.location = CLLocationCoordinate2D(latitude: 36.182588, longitude: -115.146074)
        
        let business6: ArrayInfo = ArrayInfo()
            business6.name = "Frank's Nursery"
            business6.location = CLLocationCoordinate2D(latitude: 42.168904, longitude: -82.827129)
        
        let business7: ArrayInfo = ArrayInfo()
            business7.name = "GB Photos"
            business7.location = CLLocationCoordinate2D(latitude: 46.799969, longitude: -100.773983)
        
        let business8: ArrayInfo = ArrayInfo()
            business8.name = "Hunter's Magic Shop"
            business8.location = CLLocationCoordinate2D(latitude: 33.698333, longitude: -78.916168)
        
        let business9: ArrayInfo = ArrayInfo()
            business9.name = "Kim's Wax Museum"
            business9.location = CLLocationCoordinate2D(latitude: 40.756310, longitude: -73.982191)
        
        let business10: ArrayInfo = ArrayInfo()
            business10.name = "Mobile World"
            business10.location = CLLocationCoordinate2D(latitude: 47.609295, longitude: -122.335339)
        
        
        // Pass in the businesses into the storyboard
        dataArray.append(business1)
        dataArray.append(business2)
        dataArray.append(business3)
        dataArray.append(business4)
        dataArray.append(business5)
        dataArray.append(business6)
        dataArray.append(business7)
        dataArray.append(business8)
        dataArray.append(business9)
        dataArray.append(business10)
        
    }

    // Add labels to the table view section
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UITableViewCell = tableView.dequeueReusableCell (withIdentifier: "MyCell") as UITableViewCell! {
            let currentPin: ArrayInfo = dataArray[indexPath.row]
            // Uses the local variable array as its return
            cell.textLabel!.text = currentPin.name
        
            return cell
            
        } else {
    
            return UITableViewCell()
        }
    }
    
    // Add # of rows to table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // Function connects segue from my DetailViewController to my TableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: DetailViewController = segue.destination as! DetailViewController
        let allView: AllViewController = segue.destination as? AllViewController
        let indexPath: IndexPath? = myTableView.indexPathForSelectedRow
        let currentPin: ArrayInfo = dataArray[indexPath!.row]
        detailView.currentPin = currentPin
        allView.currentPin = currentPin
    }
}
