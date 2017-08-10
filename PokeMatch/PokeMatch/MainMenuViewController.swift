//
//  MainMenuViewController.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/24/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    // Class delegates
    var gameCenter = GameCenter()
    var music = Music()
    
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var offLabel: UIImageView!
    @IBOutlet weak var gcIcon: UIView!
    
    var mute = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateGCIcon()
        handleMuteButton()
        gameCenter.authenticatePlayer()
    }
    
    // Checks if music is mute or not
    func handleMuteButton() {
        if mute {
            music.startGameMusic()
            soundButton.alpha = 1.0
            offLabel.isHidden = true
        } else {
            bgMusic?.pause()
            soundButton.alpha = 0.2
            offLabel.isHidden = false
        }
    }
    
    // Animate GC image
    func animateGCIcon() {
        UIView.animate(withDuration: 1.5, animations: {
            self.gcIcon.transform = CGAffineTransform(scaleX: 20, y: 20)
            self.gcIcon.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.gcIcon.transform = CGAffineTransform.identity
            })
        }
    }
    
    // Music button to turn music on/off
    @IBAction func muteButtonTapped(_ sender: UIButton) {
        if (bgMusic?.isPlaying)! {
            // pauses music & makes partial transparent
            bgMusic?.pause()
            sender.alpha = 0.2
            offLabel.isHidden = false
            print("Audio muted")
        } else {
            // plays music & makes full view
            bgMusic?.play()
            sender.alpha = 1.0
            offLabel.isHidden = true
            print("Audio playing")
        }
    }

    @IBAction func bestTimesButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HighScoreViewController")
        self.show(vc!, sender: self)
    }
}
