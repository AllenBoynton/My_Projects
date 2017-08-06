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
    
    // Class delegates
    let finalScoreVC = FinalScoreVC()
    let pokeMatchVC = PokeMatchVC()
    
    let musicPlayer = AVAudioPlayer()
    
    // Outlets to initialize the items
    @IBOutlet weak var bgImage: UIImageView!
    
    let imagePassed = UIImage(named: "bg")
    
    var musicSwitch: UISwitch?
    
    var sizeArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
//        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
//            selectedPhoto = editedImage
//        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            selectedPhoto = originalImage
//        }
        
        if let selectedImage = selectedPhoto {
            //Save image
            let img = UIImage() //Change to be from UIPicker
            let data = UIImagePNGRepresentation(img)
            UserDefaults.standard.set(data, forKey: "myImageKey")
            UserDefaults.standard.synchronize()
            
            //Get image
            if let imgData = UserDefaults.standard.object(forKey: "myImageKey") as? NSData {
            
                selectedPhoto = UIImage(data: imgData as Data)
                bgImage?.image =  selectedImage
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // Prepare for return from next VC when back button is tapped
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Pick new image from library
    @IBAction func selectImageFromImageLibrary(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
//        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
//        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
            
    // Button changes game screens background
    @IBAction func changeBGImageBtnPressed(_ sender: UIButton) {
        //Get image
        if let imgData = UserDefaults.standard.object(forKey: "myImageKey") as? NSData {
            let retrievedImage = UIImage(data: imgData as Data)!
            bgImage?.image =  retrievedImage
        }

        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PokeMatchVC") as! PokeMatchVC
        myVC.theImagePassed = self.bgImage.image!
        
        self.present(myVC, animated: true, completion: nil)
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
