//
//  MainMenuVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/24/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//  Image Source: © Pokémon Go
//

import UIKit
import AVFoundation

class MainMenuVC: UIViewController {
    
    var pokeMatchVC: PokeMatchVC!
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        startGameMusic()
    }

    func startGameMusic() {
        
        // Create function to initiate music playing when game begins
        let audioPath5 = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: audioPath5)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    @IBAction func singlePlayerBtnPressed(_ sender: Any) {
        
        musicPlayer.pause()
    }
    
}
