//
//  PokeMatchVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/22/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import AVFoundation

class PokeMatchVC: UIViewController {    
    
    // Local variables
    var pokemon: Pokemon!
    var pokeTiles = [Pokemon]()
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    }

    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if audioPlayer.isPlaying {
            // pauses music & makes partial transparent
            audioPlayer.pause()
            sender.alpha = 0.2
            
        } else {
            // plays music & makes full view
            audioPlayer.play()
            sender.alpha = 1.0
        }
    }
}

