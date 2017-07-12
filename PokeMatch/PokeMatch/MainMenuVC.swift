//
//  MainMenuVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/24/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//  Icon partially made by Raier from www.zerochan.net
//  http://www.zerochan.net/1037761
//

import UIKit
import AVFoundation
import UserNotifications
import GameKit


// Global identifiers
let timeLeaderboardID = "BEST_TIME" // Time Leaderboard
let pointsLeaderboardID = "HIGH_POINTS" // Score Leaderboard


class MainMenuVC: UIViewController {
    
    // Class delegates
    var pokeMatchVC = PokeMatchVC()
    
    // Create AV player
    var musicPlayer: AVAudioPlayer!
    
    // The local player object.
    let localPlayer = GKLocalPlayer.localPlayer()
    
    // Local GC variables
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    var score = 0
    var time = 0
    

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
               
                NotificationCenter.default.addObserver(
                    self, selector: #selector(self.authenticationDidChange(_:)),
                    name: NSNotification.Name(rawValue: GKPlayerAuthenticationDidChangeNotificationName),
                    object: nil)
                
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
    }
    
    func notificationReceived() {
        print("GKPlayerAuthenticationDidChangeNotificationName - Authentication Status: \(localPlayer.isAuthenticated)")
    }
    
    // Reporting score
    func saveHighScore(_ score: Int64) {
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            // Save game points to GC
            let gkScore = GKScore(leaderboardIdentifier: pointsLeaderboardID)
            gkScore.value = score
            
            let gkScoreArray: [GKScore] = [gkScore]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
                
                let vc = GKGameCenterViewController()
                vc.leaderboardIdentifier = pointsLeaderboardID
                vc.gameCenterDelegate = self as? GKGameCenterControllerDelegate
                vc.viewState = .leaderboards
                
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    // score = 2 * 60 + 22
    
    // Reporting game time
//    func saveBestTime(_ score: Int64) {
//        
//        if GKLocalPlayer.localPlayer().isAuthenticated {
//            
//            // Save game time to GC
//            let gkScore = GKScore(leaderboardIdentifier: timeLeaderboardID)
//            gkScore.value = score
//            
//            let gkScoreArray: [GKScore] = [gkScore]
//            
//            GKScore.report(gkScoreArray, withCompletionHandler: { error in
//                guard error == nil  else { return }
//                
//                let vc = GKGameCenterViewController()
//                vc.leaderboardIdentifier = pointsLeaderboardID
//                vc.gameCenterDelegate = self as? GKGameCenterControllerDelegate
//                vc.viewState = .leaderboards
//                
//                self.present(vc, animated: true, completion: nil)
//            })
//        }
//    }
    
    // Report example score after user logs in
    func authenticationDidChange(_ notification: Notification) {
        saveHighScore(0)
//        saveBestTime(Int64(score))
    }
    
    // Retrieves the GC VC leaderboard
    func showLeaderboard() {
        
        let viewController = self.view.window?.rootViewController
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self as? GKGameCenterControllerDelegate
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.leaderboardIdentifier = pointsLeaderboardID
        
        // Show leaderboard
        viewController?.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Create function to initiate music playing when game begins
    func startGameMusic() {
        
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
        
        do {
            bgMusic = try AVAudioPlayer(contentsOf: url)
            bgMusic?.prepareToPlay()
            bgMusic?.play()
            bgMusic?.numberOfLoops = -1
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    // IBActions for main menu buttons
    
    // Open Game Center Leaderboard
    @IBAction func checkGCLeaderboard(_ sender: AnyObject) {
        saveHighScore(Int64(score))
        showLeaderboard()
    }
    
    // Continue the game after GameCenter is closed
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)        
    }
}
