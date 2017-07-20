//
//  ProfileModel.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/13/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

// Create array for using the table view
class ProfileModel {
    
    // Variables used as array elements
    var id:      String?
    var name:    String?
    var idNum:   String?
    var age:     String?
    var gender:  String?
    var hobbies: String?
    var image:   String?
    
    init(id: String?, name: String?, idNum: String?, age: String?, gender: String?, hobbies: String?, image: String?) {
        self.id = id
        self.name = name
        self.idNum = idNum
        self.age = age
        self.gender = gender
        self.hobbies = hobbies
        self.image = image
    }
}
