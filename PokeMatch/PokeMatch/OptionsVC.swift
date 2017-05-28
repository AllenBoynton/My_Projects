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
//    let gameCenterVC = GameCenterVC()
    
    var musicSwitch: UISwitch!
    
    @IBOutlet weak var radioButtonOne: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        if musicSwitch.isOn {
            mainMenuVC.musicPlayer.play()
        } else {
            mainMenuVC.musicPlayer.pause()
        }
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }

}
