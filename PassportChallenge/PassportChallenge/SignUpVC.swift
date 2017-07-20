//
//  SignUpVC.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/25/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var emailSUTextField: UITextField!
    @IBOutlet weak var passwordSUTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        
        if emailSUTextField.text != "" && passwordSUTextField.text != "" {
            
            Auth.auth().createUser(withEmail: emailSUTextField.text!, password: passwordSUTextField.text!, completion: { (user, error) in
                
                if user != nil {
                    
                    // Alert to let user know that sign up was successful
                    let alert = UIAlertController(title: "Sign Up Confirmed", message: "You have been successfully signed in.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ -> Void in
                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "InitialScreenVC") as! InitialScreenVC
                        self.present(myVC, animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    
                    if let authError = error?.localizedDescription {
                        print(authError)
                        
                    } else {
                        
                        let alert = UIAlertController(title: "Error Signing Up", message: "Unknown Error", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                        
                        alert.addAction(UIAlertAction(title: "Enter as Guest", style: .default, handler: { _ -> Void in
                            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "InitialScreenVC") as! InitialScreenVC
                            self.present(myVC, animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        print("Sign up Error")
                    }
                }
            })
        } else {
            
            let alert = UIAlertController(title: "Error Signing In", message: "Must enter email and password.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
