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


class OptionsVC: UIViewController, UIPickerViewDelegate {
    
    let mainMenuVC = MainMenuVC()
    let pokeMatchVC = PokeMatchVC()
    
    var musicPlayer = AVAudioPlayer()
    
    var musicSwitch: UISwitch!
    
    @IBOutlet weak var textCardList: UITextField!
    @IBOutlet weak var dropDownList: UIPickerView!
    @IBOutlet weak var radioButtonOne: UIButton!
    
    // Card Option Themes
    var cardsArray: [(name: String, image: Any)] = [("Popular", UIImage(named: "\(25)")!), ("Powerful", UIImage(named: "\(500)")!)]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Dropdown list methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return cardsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return cardsArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.textCardList.text = self.cardsArray[row].image as? String
        self.dropDownList.isHidden = true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == self.textCardList {
            self.dropDownList.isHidden = false
        }
        textField.endEditing(true)
    }
    
//    func startGameMusic() {
//        
//        // Create function to initiate music playing when game begins
//        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
//        
//        do {
//            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
//            musicPlayer.prepareToPlay()
//            musicPlayer.numberOfLoops = -1
//            musicPlayer.play()
//            
//        } catch let err as NSError {
//            
//            print(err.debugDescription)
//        }
//    }
    
    // Button changes game screens background
    @IBAction func pushedButtonOne() {
        
        let image = UIImage(named: "bg2")
        radioButtonOne.setImage(image, for: UIControlState.normal)
    }
    
    // Button brings you to GC leaderboard
    @IBAction func gcLeaderboardBtn(_ sender: Any) {
        
        mainMenuVC.showLeaderboard()
    }
    // Audio button mutes/unmutes music
    @IBAction func musicOptionSwitch(_ sender: UISwitch) {
        
        if musicSwitch.isOn {
            musicPlayer.play()
        } else {
            musicPlayer.pause()
        }
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }

}
