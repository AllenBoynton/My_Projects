//
//  WinnersVC.swift
//  PokéMatch
//
//  Created by Allen Boynton on 6/10/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class WinnersVC: UIViewController {
    
    @IBOutlet weak var finalGamePoints: UILabel!
    @IBOutlet weak var finalGameTime: UILabel!
    
    
    // Scores passed from PokeMatchVC
    var pointsPassed = ""
    var timePassed = ""

    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Assign value to labels
        finalGamePoints.text = pointsPassed
        finalGameTime.text = timePassed

        // Sound for game over reached
        func startGameMusic() {
            
            let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "gameover", ofType: "mp3")!)
            
            do {
                gameOver = try AVAudioPlayer(contentsOf: url)
                gameOver.prepareToPlay()
                gameOver?.play()
                gameOver?.numberOfLoops = 1
            } catch let error as NSError {
                print("audioPlayer error \(error.localizedDescription)")
            }
        }
    }
}
