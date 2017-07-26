//
//  FinalScoreVC.swift
//  PokéMatch
//
//  Created by Allen Boynton on 6/10/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit
//import GoogleMobileAds

//var interstitial: DFPInterstitial?

class FinalScoreVC: UIViewController, UIAlertViewDelegate {
    
    let pokeMatchVC = PokeMatchVC()
    
    @IBOutlet weak var finalGameTime: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    // Time passed from PokeMatchVC
    var timePassed = ""
    
    // GC score variables
    var time: Int64!
    
    // AdMob variables
//    var interstitial: DFPInterstitial?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign value to labels after checking for nil
        if timePassed == "" {
            timePassed = ""
        } else {
            finalGameTime.text = timePassed
        }
        
        // Call interstitial ad function
//        interstitial = createAndLoadInterstitial() as? DFPInterstitial
    }
    
//    // Interstitial ad allocation
//    func createAndLoadInterstitial() -> GADInterstitial {
//        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712") as? DFPInterstitial
//            //"ca-app-pub-2292175261120907/5861239922") as? DFPInterstitial
//        interstitial?.delegate = self as? GADInterstitialDelegate
//        
//        let request = GADRequest()
//        interstitial?.load(request)
//        request.testDevices = [ kGADSimulatorID,   // All simulators
//            "7ed9d992b26e0010d4bee7686ba6b7e30224852b" ]  // iPad device ID
//        
//        return interstitial!
//    }
//    
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        interstitial = createAndLoadInterstitial() as? DFPInterstitial
//    }
    
    // Reporting game time
    func saveBestTime(_ time: Int64) {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            // Save game time to GC
            let gkScore = GKScore(leaderboardIdentifier: timeLeaderboardID)
            gkScore.value = time
            
            let gkScoreArray: [GKScore] = [gkScore]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
                
                let vc = GKGameCenterViewController()
                vc.leaderboardIdentifier = timeLeaderboardID
                vc.gameCenterDelegate = self as? GKGameCenterControllerDelegate
                vc.viewState = .leaderboards
                
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    // Continue the game after GameCenter is closed
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // Restart game button to main menu
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        saveBestTime(time)
        print("\(time)")
        
        // Call ad
//        if (interstitial?.isReady)! {
//            interstitial?.present(fromRootViewController: self)
//        } else {
//            print("Ad wasn't ready")
//        }
        
        navigationController?.popToRootViewController(animated:true)
    }
}
