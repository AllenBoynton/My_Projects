//
//  OptionsVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/26/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import AVFoundation
import GameKit

class OptionsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let mainMenuVC = MainMenuVC()
    let pokeMatchVC = PokeMatchVC()
    
    let musicPlayer = AVAudioPlayer()
    
    // Outlets to initialize the items
    @IBOutlet weak var bgImage: UIImageView!
    
    let imagePassed = UIImage(named: "bg")
    
    var musicSwitch: UISwitch?
    
    var difficultyArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Picker data
        difficultyArray = ["Easy", "Medium", "Hard"]
    }
    
    // Create function to initiate music playing when game begins
    func startGameMusic() {
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
        
        do {
            bgMusic = try AVAudioPlayer(contentsOf: url)
            bgMusic?.prepareToPlay()
            bgMusic?.play()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    // Image picker picks selected image and dismisses VC
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage
        bgImage.image = selectedPhoto
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedPhoto = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedPhoto = originalImage
            
           // ****************************************
            
        } // Code if no image is picked to use default
        
        if let selectedImage = selectedPhoto {
            bgImage?.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // Prepare for return from next VC when back button is tapped
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Pick new image from library
    @IBAction func selectImageFromImageLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
            
    // Button changes game screens background
    @IBAction func changeBGImageBtnPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Would you like to personalize your background?", message: "Tap the image above the \"Change\" button to pick a New Image", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Change it!", style: .default , handler: nil))
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ -> Void in
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PokeMatchVC") as! PokeMatchVC
            myVC.theImagePassed = self.bgImage.image!
            self.present(myVC, animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        // Change font of the title and message
        let _: [String : AnyObject] = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Bold", size: 18)!]
        let _: [String : AnyObject] = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Medium", size: 14)!]
    }
    
    // Button brings you to GC leaderboard
    @IBAction func gcLeaderboardBtn(_ sender: Any) {
        mainMenuVC.showLeaderboard()
    }
    
    // Audio button mutes/unmutes music
    @IBAction func musicOptionSwitch(_ sender: UISwitch) {
        if sender.isOn {
            musicSwitch?.setOn(false, animated: true)
            startGameMusic()
        } else {
            musicSwitch?.setOn(true, animated: true)
            musicSwitch?.isOn = true
            
            if bgMusic != nil {
                bgMusic?.pause()
                bgMusic = nil
            }
        }
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
