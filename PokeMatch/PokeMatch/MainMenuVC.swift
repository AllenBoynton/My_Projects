//
//  MainMenuVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/24/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications
import GameKit
import Firebase

// Global identifiers
let timeLeaderboardID = "BEST_TIME" // Time Leaderboard
let pointsLeaderboardID = "HIGH_POINTS" // Score Leaderboard


class MainMenuVC: UIViewController {
    
    // Class delegates
    var pokeMatchVC = PokeMatchVC()
    var winnersVC = WinnersVC()
    
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
    
    // Report example score after user logs in
    func authenticationDidChange(_ notification: Notification) {
        winnersVC.saveHighScore(10)
        winnersVC.saveBestTime(20000)
    }
    
    //
    func notificationReceived() {
        print("GKPlayerAuthenticationDidChangeNotificationName - Authentication Status: \(localPlayer.isAuthenticated)")
    }
    
    // Retrieves the GC VC leaderboard
    func showLeaderboard() {
        let viewController = self.view.window?.rootViewController
        let gameCenterViewController = GKGameCenterViewController()
        
        gameCenterViewController.gameCenterDelegate = self as? GKGameCenterControllerDelegate
        gameCenterViewController.viewState = .leaderboards
//        gameCenterViewController.leaderboardIdentifier = pointsLeaderboardID
        gameCenterViewController.leaderboardIdentifier = timeLeaderboardID
        
        // Show leaderboard
        viewController?.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Continue the game after GameCenter is closed
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
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
    @IBAction func startButtonTapped(_ sender: UIButton) {
        Analytics.logEvent("start_button_pressed", parameters: nil)
    }
    
    // Open Game Center Leaderboard
    @IBAction func checkGCLeaderboard(_ sender: AnyObject) {
        Analytics.logEvent("check_leaderboard_button_pressed", parameters: nil)
        winnersVC.saveHighScore(Int64(score))
        winnersVC.saveBestTime(Int64(time))
        showLeaderboard()
    }
}
