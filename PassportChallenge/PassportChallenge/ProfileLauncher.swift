//
//  ProfileLauncher.swift
//  PassportChallenge
//
//  Created by Allen Boynton on 6/19/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileLauncher: MainProfileVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    // Local variables
    var selectedPhoto: UIImage!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func uploadImageToFirebaseStorage(data: NSData) {
        
        let storageRef = Storage.storage().reference(withPath: "uploadPhotos/hillary.png")
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/png"
        
        let uploadTask = storageRef.putData(data as Data, metadata: uploadMetadata) { (metadata, error) in
            
            if (error != nil) {
                
                print("I received an error! \(String(describing: error?.localizedDescription))")
                
            } else {
                
                print("Upload complete! Metadata: \(String(describing: metadata))")
                print("Image download URL: \(String(describing: metadata?.downloadURL()))")
            }
        }
        
        // Update progress bar
        uploadTask.observe(.progress) { [weak self] (snapshot) in
            
            guard let strongSelf = self else {return}
            guard let progress = snapshot.progress else {return}
            
            strongSelf.progressView.progress = Float(progress.fractionCompleted)
        }
    }
    
    
    // MARK: Collect photo from photoLibrary
    
    // Image picker picks selected image and dismisses VC
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            selectedPhoto = editedImage
            
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            selectedPhoto = originalImage
        }
        
        if let selectedImage = selectedPhoto {
            
            imageThumbnail?.image = selectedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // Prepare for return from next VC when back button is tapped
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // Pick image from library
    @IBAction func addNewPhotoButton(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: TextField delegate methods
    
    // Handle text fields as first responders to use keyboard properly
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        return true
    }
    
    // Dismiss overlay by touching background
    @IBAction func dismissOverlay(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
