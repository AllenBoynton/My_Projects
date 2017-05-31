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


class OptionsVC: UIViewController {
    
    let mainMenuVC = MainMenuVC()
    let pokeMatchVC = PokeMatchVC()
    
    var musicPlayer = AVAudioPlayer()
    
    // Outlets to initialize the items
    @IBOutlet weak var difficultyPicker: UIPickerView!
    @IBOutlet weak var radioButtonOne: UIButton!
    
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
            bgMusic! = try AVAudioPlayer(contentsOf: url)
            bgMusic!.delegate = self as? AVAudioPlayerDelegate
            bgMusic!.prepareToPlay()
            bgMusic!.play()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
        
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
        
        if (sender.isOn == true) {
            musicSwitch?.setOn(false, animated: true)
            bgMusic?.play()
        } else {
            musicSwitch?.setOn(true, animated: true)
            musicSwitch?.isOn = true
            bgMusic?.pause()
        }
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }

}
