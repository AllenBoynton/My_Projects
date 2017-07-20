//
//  MainProfileVC.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/12/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


// Global Identifiers
    // VCs - Stvarboards
let detailVC = "ChallengeDetailsVC"

    // Segue Identifiers
let toDetailsVC = "toDetailsVC"
let toOverlay = "toModalOverlay"

    // Cell Identifiers
var profileCell = "ProfileCell"


class MainProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Configure Firebase database
    var refProfiles: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    
    // Class delegates
    var detailsVC = ProfileDetailsVC()
    
    // Created a filtered array to be used when filtering results of tableView
    var filteredArray: [ProfileModel]!
    
    // Data retrieved from database as it changes
    var profileData = [ProfileModel]()
    
    
    // Outlets to connect objects to code
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedFilterControl: SquaredSegmentedControl!
    
    // All outlets for the overlay screen
    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var genderInput: UITextField!
    @IBOutlet weak var hobbyInput: UITextField!
    
    @IBOutlet weak var backgroundButton: UIButton?
    
    // Local variables
    var profileAdded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set MainVC title
        navigationItem.title = "Profiles"
                
        // Copy data to filtered array
//        self.filteredArray = self.profileData
        
        defaultIDSort()
        
        // Firebase fetch of data and listen for changes
        refProfiles = Database.database().reference().child("Profiles")
        
        refProfiles.observe(.value, with: { (snapshot) in
            
            // If check to see there is data
            if snapshot.childrenCount > 0 {
                self.profileData.removeAll()
                
                // Code to execute when child is added
                for object in snapshot.children.allObjects as![DataSnapshot] {
                    
                    let profileObject = object.value as? [String : Any]
                    
                    let id = profileObject?["id"]
                    let name = profileObject?["name"]
                    let idNum = profileObject?["idNum"]
                    let age = profileObject?["age"]
                    let gender = profileObject?["gender"]
                    let hobbies = profileObject?["hobbies"]
                    let image = profileObject?["image"]
                    
                    let profile = ProfileModel(id: id as! String?,
                                               name: name as! String?,
                                               idNum: idNum as! String?,
                                               age: age as! String?,
                                               gender: gender as! String?,
                                               hobbies: hobbies as! String?,
                                               image: image as! String?)
                    
                    // Append data to the filtered array
                    self.profileData.append(profile)
                    print("Image = \(String(describing: image))")
                }
                // Reload the tableview
                self.tableView?.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    // MARK: Firebase function to add data to the database
    
    // Add data to realtime FB database
    func addProfile() {
        
        let key = refProfiles.childByAutoId().key
        
        // Array that is sent to database
        let profile: [String : Any] = ["id": key,
                                       "name": nameInput.text!,
                                       "idNum": idInput.text!,
                                       "age": ageInput.text!,
                                       "gender": genderInput.text!,
                                       "hobbies": hobbyInput.text!,
                                       "image": "\(imageThumbnail.image!)"
        ]
        
        refProfiles.child(key).setValue(profile)
    }
    
    
    // MARK: Table View Protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    // Assign tableview data source to cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the data from the tableview cell
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCell, for: indexPath) as! ProfileViewCell
        
        let profile = profileData[indexPath.row]
        
        // Populate the table view with the array data
        cell.nameLabel.text = profile.name
        cell.iDLabel.text = profile.idNum
        cell.ageLabel.text = profile.age
        cell.genderLabel.text = profile.gender
        
        // Profile may not have image. Default one provided.
        if (profile.image != "") {
            if let image = profile.image {
                print("Image = \(image)")
                cell.profileImage.image = UIImage(named: image)
            } else {
                cell.profileImage.image = UIImage(named: "defaultUser")
            }
        }
        
        // Assign color code for each gender
        let maleCellColor = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1.0)
        let femaleCellColor = UIColor(red: 102/255, green: 255/255, blue: 102/255, alpha: 1.0)
        
        // Changes cell color background determined by gender
        if let gender = profile.gender {
            switch gender {
                
            case "Male":
                cell.backgroundColor = maleCellColor
            case "Female":
                cell.backgroundColor = femaleCellColor
            default:
                cell.backgroundColor = .clear
            }
        }
        return cell
    }
    
    // Function connects segue from View Controller to Detail View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toDetailsVC {
            let detailView = (segue.destination as? ProfileDetailsVC)!
            let indexPath = tableView.indexPathForSelectedRow
            detailView.profiles = profileData[indexPath!.row]
        }        
    }
    
    // Default sorting
    func defaultIDSort() {
        profileData.sort() { $0.idNum! < $1.idNum! }
    }
    
    // Sort list by age in ascending order
    func sortAscendingAge() {
        profileData.sort { $0.age! < $1.age! }
    }
    
    // Sort list by age in descending order
    func sortDescendingAge() {
        profileData.sort { $0.idNum! > $1.idNum! }
    }
    
    // Sort list by Name in ascending order
    func sortAscendingName() {
        profileData.sort { $0.name! < $1.name! }
    }
    
    // Sort list by Name in descending order
    func sortDescendingName() {
        profileData.sort { $0.name! > $1.name! }
    }
    

    // MARK: Save to Firebase database button
    
    // Button saves new data to FB DB then dismisses
    @IBAction func saveToDatabase(_ sender: Any) {
        // Firebase database logic
        addProfile()
        profileAdded = true
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // Sets the actions per segment and its action
    @IBAction func filterSegmentsPressed(_ sender: AnyObject) {
        
        switch segmentedFilterControl.selectedSegmentIndex {
        case 0:
            defaultIDSort()
        case 1:
            sortAscendingAge()
        case 2:
            sortAscendingName()
        case 3:
            print("Change gender cells")
        case 4:
            defaultIDSort()
        default:
            defaultIDSort()
        }
        
        tableView.reloadData()
    }
    
    // Logs user out
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginAuthVC") as! LoginAuthVC
        self.present(myVC, animated: true, completion: nil)
    }
    
}

// 226/152/20/0.5
