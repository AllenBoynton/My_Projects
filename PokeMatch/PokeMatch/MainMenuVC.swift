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
import GameKit

// Global identifiers
//let timeLeaderboardID = "BEST_TIME"
let pointsLeaderboardID = "HIGH_POINTS"

class MainMenuVC: UIViewController, GKGameCenterControllerDelegate {
    
    // Class delegates
    var pokeMatchVC: PokeMatchVC!
//    var gameCenterVC: GameCenterVC!
    var musicPlayer: AVAudioPlayer!
    
    // The local player object.
    let localPlayer = GKLocalPlayer.localPlayer()
    
    // Local GC variables
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authenticatePlayer()
        startGameMusic()
    }
    
    // Authenticates the user to access to the GC
    func authenticatePlayer() {
        
        localPlayer.authenticateHandler = {(view, error) -> Void in
            if((view) != nil) {
                
                // 1. Show login if player is not logged in
                self.present(view!, animated: true, completion: nil)
                
            } else if (self.localPlayer.isAuthenticated) {
                
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
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(authenticationDidChange(_:)),
            name: NSNotification.Name(rawValue: GKPlayerAuthenticationDidChangeNotificationName),
            object: nil
        )
    }
    
    func notificationReceived() {
        print("GKPlayerAuthenticationDidChangeNotificationName - Authentication Status: \(localPlayer.isAuthenticated)")
    }
    
    // Reporting score
    func saveHighScore(_ score: Int64) {
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            let gkScore = GKScore(leaderboardIdentifier: pointsLeaderboardID)
            gkScore.value = score
            
            let gkScoreArray: [GKScore] = [gkScore]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
                
                let vc = GKGameCenterViewController()
                vc.leaderboardIdentifier = pointsLeaderboardID
                vc.gameCenterDelegate = self
                vc.viewState = .leaderboards
                
                self.present(vc, animated: true, completion: nil)   })
        }
    }
    
    // Report example score after user logs in
    func authenticationDidChange(_ notification: Notification) {
        saveHighScore(0)
    }
    
    // Retrieves the GC VC leaderboard
    func showLeaderboard() {
        
        let viewController = self.view.window?.rootViewController
        
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.leaderboardIdentifier = pointsLeaderboardID
        
        // Show leaderboard
        viewController?.present(gameCenterViewController, animated: true, completion: nil)
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
    
    // Open Game Center Leaderboard
    @IBAction func checkGCLeaderboard(_ sender: AnyObject) {
        
        // Add points to current score
        score += 10
        pokeMatchVC.pointsDisplay.text = "\(score)"
        
        // Submit score to GC leaderboard
        let bestScoreInt = GKScore(leaderboardIdentifier: pointsLeaderboardID)
        bestScoreInt.value = Int64(pokeMatchVC.gamePoints)
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
        }

        
        saveHighScore(Int64(score))
        showLeaderboard()
    }
    
    // Add points to the score and submit to GC
//    @IBAction func addScoreAndSubmitToGC(_ sender: AnyObject) {
//        var score = 0
//        // Add points to current score
//        score += 1
//        pokeMatchVC.pointsDisplay.text = "\(score)"
//        
//        // Submit score to GC leaderboard
//        let bestScoreInt = GKScore(leaderboardIdentifier: pointsLeaderboardID)
//        bestScoreInt.value = Int64(pokeMatchVC.gamePoints)
//        GKScore.report([bestScoreInt]) { (error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            } else {
//                print("Best Score submitted to your Leaderboard!")
//            }
//        }
//    }
    
    // Continue the game after GameCenter is closed
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        
        gameCenterViewController.dismiss(animated: true, completion: nil)        
    }
}
