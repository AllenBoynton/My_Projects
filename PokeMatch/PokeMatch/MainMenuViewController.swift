//
//  MainMenuViewController.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/24/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

// Global GC identifiers
let timeLeaderboardID = "BEST_TIME" // Time Leaderboard

class MainMenuViewController: UIViewController {
    
    // Class delegates
    let gameController = PokeMemoryGame()
    var music = Music()
    
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var gcIcon: UIView!
    
    let localPlayer = GKLocalPlayer.localPlayer()
    
    lazy var gcEnabled = Bool() // Check if the user has Game Center enabled
    lazy var gcDefaultLeaderBoard = String() // Check the default
    
    let score = 0
    
    lazy var mute = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameController.delegate = self as? MemoryGameDelegate
        
        authenticatePlayer()
        animateGCIcon()
        handleMuteButton()
    }
    
    // Authenticates the user to access to the GC
    func authenticatePlayer() {
        localPlayer.authenticateHandler = {(view, error) -> Void in
            if view != nil {
                
                // 1. Show login if player is not logged in
                self.present(view!, animated: true, completion: nil)
                
                NotificationCenter.default.addObserver(
                    self, selector: #selector(self.authenticationDidChange(_:)),
                    name: NSNotification.Name(rawValue: GKPlayerAuthenticationDidChangeNotificationName),
                    object: nil)
                
            } else if self.localPlayer.isAuthenticated {
                
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                self.localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifier, error) in
                    if error != nil {
                        print(error as Any)
                    } else {
                        self.gcDefaultLeaderBoard = leaderboardIdentifier!
                    }
                })
            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error as Any)
            }
        }
    }

    // Report example score after user logs in
    func authenticationDidChange(_ notification: Notification) {
        saveHighScore(100)
    }
    
    // Authentication notification
    func notificationReceived() {
        print("GKPlayerAuthenticationDidChangeNotificationName - Authentication Status: \(localPlayer.isAuthenticated)")
    }
    
    // Reporting game time
    func saveHighScore(_ score: Int64) {
        // if player is logged in to GC, then report the score
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            // Save game time to GC
            let scoreReporter = GKScore(leaderboardIdentifier: timeLeaderboardID)
            scoreReporter.value = Int64(score)
            
            let gkScoreArray: [GKScore] = [scoreReporter]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
            })
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
    
    // Checks if music is mute or not
    func handleMuteButton() {
        if mute {
            music.startGameMusic()
            soundButton.alpha = 1.0
        } else {
            bgMusic?.pause()
            soundButton.alpha = 0.2
        }
    }

    // Music button to turn music on/off
    @IBAction func muteButtonTapped(_ sender: UIButton) {
        if (bgMusic?.isPlaying)! {
            // pauses music & makes partial transparent
            bgMusic?.pause()
            sender.alpha = 0.2
            print("Audio muted")
        } else {
            // plays music & makes full view
            bgMusic?.play()
            sender.alpha = 1.0
            print("Audio playing")
        }
    }

    @IBAction func bestTimesButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HighScoreViewController")
        self.show(vc!, sender: self)
    }
}
