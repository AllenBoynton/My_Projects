//
//  ProfileDetailsVC.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/12/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileDetailsVC: UIViewController {
    
    var profiles: ProfileModel?
    var refProfiles: DatabaseReference!
    
    // Outlets to connect info to details screen
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var hobbiesTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data from our Model is displayed with said variables
        profileImage.image = UIImage(named: (profiles?.image)!)
        nameLabel.text! = (profiles?.name)!
        ageTextField.text! = (profiles?.age)!
        genderTextField.text! = (profiles?.gender)!
        hobbiesTextField.text! = (profiles?.hobbies)!
        
        // Firebase fetch of data and listen for changes
        refProfiles = Database.database().reference()
    }
    
    // Needed for profile deletion
    func deleteProfile(id: String) {
        refProfiles.child(id).setValue(nil)
    }
    
    // Button will send new data to database and update hobbies
    @IBAction func updateProfiles(_ sender: AnyObject) {
        // Variables to check for ""

    }
    
    // Button is pressed and function is called in didSelectRowAtIndexPath
    @IBAction func deleteProfile(_ sender: UIBarButtonItem) {
        self.deleteProfile(id: (profiles?.id)!)
    }
}
