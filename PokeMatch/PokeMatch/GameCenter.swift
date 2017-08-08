//
//  GameCenter.swift
//  PokéMatch
//
//  Created by Allen Boynton on 8/7/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class GameCenter: UIViewController {
    
    let gameController = PokeMemoryGame()
    
    // The local player object.
    let localPlayer = GKLocalPlayer.localPlayer()
    
    // Local GC variables
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    
    let score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Game delegate
        gameController.delegate = self as? MemoryGameDelegate
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
        saveHighScore(score)
    }
    
    // Authentication notification
    func notificationReceived() {
        print("GKPlayerAuthenticationDidChangeNotificationName - Authentication Status: \(localPlayer.isAuthenticated)")
    }
    
    // Retrieves the GC VC leaderboard
    func showLeaderboard() {
        let gameCenterViewController = GKGameCenterViewController()
        
        gameCenterViewController.gameCenterDelegate = self as? GKGameCenterControllerDelegate
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.leaderboardIdentifier = timeLeaderboardID
        
        // Show leaderboard
        self.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Reporting game time
    func saveHighScore(_ score: Int) {
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
}
