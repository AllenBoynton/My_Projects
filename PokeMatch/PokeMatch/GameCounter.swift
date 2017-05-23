//
//  GameCounter.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class GameCounter {
    
    // MARK: - Game counter
    
    // NSTimers for game counter
    var timer: Timer?
    
    // Time values instantiated
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var display: String = ""
    
    // Oulet for timer display
    @IBOutlet weak var timerDisplay: UILabel!
    
    // Starts time when play button is pressed.
    func startGameTime() {
        
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    // Updates game time on displays
    func updateCounter () -> String {
        
        // Calculate total time since timer started in seconds
        time = Date().timeIntervalSinceReferenceDate - startTime
        
        // Calculate minutes
        let minutes = UInt8(time / 60.0)
        time -= (TimeInterval(minutes) * 60)
        
        // Calculate seconds
        let seconds = UInt8(time)
        time -= TimeInterval(seconds)
        
        // Calculate milliseconds
        let milliseconds = UInt8(time * 100)
        
        // Format time vars with leading zero
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)
        
        // Add time vars to relevant labels
        display = "\(strMinutes):\(strSeconds):\(strMilliseconds)"
        timerDisplay.text = display
        timerDisplay2.text = display
        print(display)
        
        return display
    }

}
