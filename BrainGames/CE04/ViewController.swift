//
//  ViewController.swift
//  CE04 - Adaptive Layout Project
//
//  Created by Allen Boynton on 6/3/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // Outlets for views within a storyboard
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var winnersView: UIView!
    @IBOutlet weak var utilityView: UIView!
    
    // Outlet for initial play button
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startButton2: UIButton!
    @IBOutlet weak var restartButton: UIButton!

    // Oulet for timer display
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var timerDisplay2: UILabel!
    @IBOutlet weak var winningTimeText: UILabel!
    
    // Outlet Collection for Card View
    @IBOutlet var cardViewArray: [UIView] = []
    
    // Outlet Collection for Card Images
    @IBOutlet var cardImageArray: [UIImageView] = []
    
    // Local variables - all values change thoughout the game
    
    // Image array
    var cardImages: [String] = []
    
    // View array of Images selected
    var selectedCards: [UIView] = []
    
    // Deducts images until we reach 0 and the user wins
    var cardCounter = 0
    
    // NSTimers for game counter and delays in revealed images
    var timer: Timer?
    var timer1 = Timer(), timer2 = Timer(), timer3 = Timer()
    
    // Time values instantiated
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var display: String = ""

    // Audio player
    var cheering = AVAudioPlayer()
    var tadaSound = AVAudioPlayer()
    var patSound = AVAudioPlayer()
    var chime = AVAudioPlayer()
    var wrongAnswer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize tap gesture
        for view in cardViewArray {
            view.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesture))
            view.addGestureRecognizer(tapGesture)
        }
        
        // Hides card views before game play starts.
        for view in cardViewArray {
            view.isHidden = true
            print("View hidden before starting - viewDidLoad")
        }
        
        // Check to see how many buttons are on the screen to determine iPhone or iPad.
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            // iPhone array for 20 buttons
            cardImages = [
                "military chainsaw.png", "tools rope.png", "tools saw.png",
                "tools screwdriver.png", "tools shovel.png", "tools swiss knife.png",
                "tools torch.png", "tools wrench.png", "weapons gaunlets.png",
                "weapons katana.png", "military chainsaw.png", "tools rope.png", "tools saw.png",
                "tools screwdriver.png", "tools shovel.png", "tools swiss knife.png",
                "tools torch.png", "tools wrench.png", "weapons gaunlets.png",
                "weapons katana.png"
            ]
            // Call function to populate images
            randomImageLoop()
            
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            
            // iPad array for 30 buttons
            cardImages = [
                "military chainsaw.png", "tools rope.png", "tools saw.png",
                "tools screwdriver.png", "tools shovel.png", "tools swiss knife.png",
                "tools torch.png", "tools wrench.png", "weapons gaunlets.png",
                "weapons katana.png", "magic wizard hat.png", "weapons medieval helmet.png",
                "weapons medieval sword.png", "weapons sledgehammer.png", "weapons wood shield.png",
                "military chainsaw.png", "tools rope.png", "tools saw.png",
                "tools screwdriver.png", "tools shovel.png", "tools swiss knife.png",
                "tools torch.png", "tools wrench.png", "weapons gaunlets.png",
                "weapons katana.png", "magic wizard hat.png", "weapons medieval helmet.png",
                "weapons medieval sword.png", "weapons sledgehammer.png", "weapons wood shield.png"
            ]
            randomImageLoop()
        }
        
        // Verify value of array indices
        print(cardImageArray.indices)
        
        // Play button attributes
        if let play = playButton {
            play.layer.cornerRadius = 6
            play.layer.borderWidth = 2
            play.layer.borderColor = UIColor.black.cgColor
        }
        
        // Start button attributes
        if let start = startButton {
            start.layer.cornerRadius = 6
            start.layer.borderWidth = 2
            start.layer.borderColor = UIColor.black.cgColor
        }
        
        if let start = startButton2 {
            start.layer.cornerRadius = 6
            start.layer.borderWidth = 2
            start.layer.borderColor = UIColor.black.cgColor
        }
        
        // Timer display attributes
        if let display = timerDisplay {
            display.layer.borderWidth = 2
            display.layer.borderColor = UIColor.black.cgColor
        }
        
        if let display = timerDisplay2 {
            display.layer.borderWidth = 2
            display.layer.borderColor = UIColor.black.cgColor
        }
        
        utilityView?.layer.borderWidth = 2
        utilityView?.layer.borderColor = UIColor.yellow.cgColor
    }
    
    // for in loop to populate array images by removing a random one at a time while array depletes to ensure pairs
    func randomImageLoop() {
        for index in cardImageArray {
            if cardImages.count > 0 {
                cardCounter += 1
                let random = arc4random_uniform(UInt32(cardImages.count))
                index.image = UIImage(named: cardImages.remove(at: Int(random)))
                index.layer.borderWidth = 2
                index.layer.borderColor = UIColor.black.cgColor
                index.isHidden = true
                print("Images populating & Images Hidden")
            }
        }
    }
    
    // Sound files
    func prepareAudios() {
        
        let audioPath1 = Bundle.main.path(forResource: "Cheering", ofType: "mp3")!
        
        do {
            cheering = try AVAudioPlayer(contentsOf: URL(string: audioPath1)!)
            cheering.prepareToPlay()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
        let audioPath2 = Bundle.main.path(forResource: "taDa", ofType: "mp3")!
        
        do {
            tadaSound = try AVAudioPlayer(contentsOf: URL(string: audioPath2)!)
            tadaSound.prepareToPlay()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
        let audioPath3 = Bundle.main.path(forResource: "chime", ofType: "mp3")!
        
        do {
            chime = try AVAudioPlayer(contentsOf: URL(string: audioPath3)!)
            chime.prepareToPlay()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
        let audioPath4 = Bundle.main.path(forResource: "Pat", ofType: "mp3")!
        
        do {
            patSound = try AVAudioPlayer(contentsOf: URL(string: audioPath4)!)
            patSound.prepareToPlay()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    // MARK: - Time counter
    
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
    
    // Function assigns views with tap gestures
    func tapGesture (_ sender: UITapGestureRecognizer) {
        
        // Checks if the user has selected more than 0 cards.
        if selectedCards.count > 0 {
            
            // if/else statement to deselect a card if the user retaps the same one.
            if sender.view?.description != selectedCards[0].description {
                selectedCards.append(sender.view!)
                (sender.view?.subviews[0] as! UIImageView).isHidden = false
            } else {
                // If 2 cards are selected and have different descriptions, the images are hidden.
                keepCard()
            }
            print("Tapped - No Match")
            
        // If there isn't more than one box in the the array, we have to remove the description check or else that array index will be nil and will cause a crash. We still add the selected box to the array.
        } else {
            selectedCards.append(sender.view!)
            (sender.view?.subviews[0] as! UIImageView).isHidden = false
            print("Tapped - Image Added to Array")
        }
        
        // If statement to check if 2 cards have been selected.
        if selectedCards.count == 2 {
            
            // If statement checks subviews to see if they match.
            if (selectedCards[0].subviews[0] as! UIImageView).image == (selectedCards[1].subviews[0] as! UIImageView).image {
                (sender.view?.subviews[0] as! UIImageView).isHidden = false
                // Disable user interaction so that they cannot tap any other cards.
                view.isUserInteractionEnabled = false
                
                // Start a timer for .5 second so user can see the match. Calls removeCards function
                timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.removeCards), userInfo: nil, repeats: false)
                print("Tapped if 2 cards")
            } else {
                (sender.view?.subviews[0] as! UIImageView).isHidden = false
                view.isUserInteractionEnabled = false
                // Start timer for .5 second so user can see images were NOT a match. Calls hideCards function
                timer3 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.keepCard), userInfo: nil, repeats: false)
                print("Tapped if 2 cards -else")
            }
        }
    }
    
    // Function used to re-hide images when the user does not get a match.
    func keepCard () {
        
        // Not a match sound
        prepareAudios()
        patSound.play()

        for card in selectedCards {
            card.layer.borderWidth = 2
            card.layer.borderColor = UIColor.yellow.cgColor
            card.backgroundColor = UIColor.black
            (card.subviews[0] as! UIImageView).isHidden = true
        }
        
        // Removes the selected boxes from the selected boxes array, allowing the user to start selecting more boxes.
        selectedCards.removeAll(keepingCapacity: false)
        
        // Renables user interaction.
        view.isUserInteractionEnabled = true
    }
    
    // Function used to hide boxes when the user gets a match.
    func removeCards () {
        
        // Correct match sound
        prepareAudios()
        chime.play()

        for card in selectedCards {
            card.isHidden = true
        }

        // Removes the count of 1 card per selection so we know how many cards are left.
        cardCounter -= 1
        cardCounter -= 1
        
        selectedCards.removeAll(keepingCapacity: false)
        
        // Checks if the number of cards has reached 0.
        if cardCounter == 0 {
            
            // Winning cheers
            prepareAudios()
            tadaSound.play()
            cheering.play()
            
            // Stops the game counter once game is completed.
            timer?.invalidate()
            
            // Reveals the winner's screen.
            gameView.isHidden = true
            winnersView.isHidden = false
            
            // Adds the winning text phrase to the winner's screen label.
            winningTimeText.text! = "You finished in \(display) seconds!"
        }
        
        // Enables the user's interaction once two boxes are matched.
        view.isUserInteractionEnabled = true
    }
    
    // Function hides images for after the first 5 seconds game preview.
    func seeInitialView(_ sender: UIButton) {
        
        // Enable user interaction to select views
        view.isUserInteractionEnabled = true
        
        // Hides card Image and displays View to now select
        for images in cardImageArray {
            images.isHidden = true
            print(" 3. Image Hidden - seeInitialView - After Preview")
        }
        
        for view in cardViewArray {
            view.isHidden = false
            print("4. View NOT Hidden - seeInitialView - After Preview")
        }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        
        // Button sound
        prepareAudios()
        patSound.play()
        
        // Calls functions
        startGameTime()
        
        // Ensures user can not tap buttons while showing 5 second preview.
        view.isUserInteractionEnabled = false
        
        // Delay images to be shown for 5 seconds.
        self.timer1 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ViewController.seeInitialView(_:)), userInfo: nil, repeats: false)
        
        startButton.isHidden = true
        startButton2.isHidden = true
        
        // Displays Views and Images for the 5 second preview.
        for views in cardViewArray {
            views.layer.borderWidth = 2
            views.layer.borderColor = UIColor.black.cgColor
            views.isHidden = false
            print(" 1. View NOT Hidden - startButton - Preview")
        }
        
        for images in cardImageArray {
            images.isHidden = false
            print(" 2. Image NOT Hidden - startButton - Preview")
        }
    }
    
    // Button dismisses VC to return to Intro screen
    @IBAction func restartGame(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        // Button sound 
        prepareAudios()
        patSound.play()
        
        startButton.isHidden = false
        startButton2.isHidden = false
    }
}

