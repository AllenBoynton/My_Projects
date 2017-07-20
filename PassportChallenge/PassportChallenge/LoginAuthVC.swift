//
//  LoginAuthVC.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/25/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginAuthVC: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                if user != nil {
                    
                    self.performSegue(withIdentifier: "toInitialScreenVC", sender: self)
                } else {
                    
                    if let authError = error?.localizedDescription {
                        
                        let alert = UIAlertController(title: "Error logging in", message: "User not found, please Sign Up.", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                        
                        alert.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: { _ -> Void in
                            self.performSegue(withIdentifier: "toSignUpVC", sender: self)
                            
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        print(authError)
                    } else {
                        
                        print("Error - User not found, please sign up.")
                    }
                }
            })
        } else {
            
            let alert = UIAlertController(title: "Error Logging In", message: "Must enter email and password.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func retrievePassword(_ sender: UIButton) {
        
        if emailTextField.text != "" {
            
            let alert = UIAlertController(title: "An email has been sent.", message: "Follow instructions in your email to reset your password.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            // Setup up password retrieval by email
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Forgot Password?", message: "Must enter your email to reset password.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
