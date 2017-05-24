//
//  PokeMatchVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/22/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import AVFoundation

class PokeMatchVC: UIViewController {
    
    var pokemon: Pokemon!
    var musicPlayer: AVAudioPlayer!
    
    // Outlet for game points
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsDisplay: UILabel!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var startButton: UIButton!

    // Oulet for timer display
    @IBOutlet weak var timerDisplay: UILabel!
    
    // Outlet Collection for Tile View
    @IBOutlet var tileViewArray: [UIView] = []
    
    // Outlet Collection for Tile Images
    @IBOutlet var pokeImageArray: [UIImageView] = []
    
    // Local variables - all values change thoughout the game
    
    // Image array
    var pokeImages: [UIImage] = []
    
    // View array of Images selected
    var selectedTiles: [UIView] = []
    
    // Deducts images until we reach 0 and the user wins
    var tileCounter = 0
    var gamePoints = 0
    
    // NSTimers for game time and delays in revealed images
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
        for view in tileViewArray {
            view.isUserInteractionEnabled = true
            let taps = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
            view.addGestureRecognizer(taps)
        }
        
        // Hides card views before game play starts.
        for view in tileViewArray {
            view.isHidden = true
            print("View hidden before starting - viewDidLoad")
        }
        
        // Check to see how many buttons are on the screen to determine iPhone or iPad.
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            // iPhone array for 20 buttons
//            for i in 1...719 {
                pokeImages = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!
                ]
//            }
            // Call function to populate images
            randomImageLoop()
            
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            
            // iPad array for 30 buttons
            pokeImages = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "11")!, UIImage(named: "12")!, UIImage(named: "13")!, UIImage(named: "14")!, UIImage(named: "15")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "10")!, UIImage(named: "11")!, UIImage(named: "12")!, UIImage(named: "13")!, UIImage(named: "14")!, UIImage(named: "15")!
            ]
            randomImageLoop()
        }
        
        // Verify value of array indices
        print(pokeImageArray.indices)
        
        startGameMusic()
    }
    
    // for in loop to populate array images by removing a random one at a time while array depletes to ensure pairs
    func randomImageLoop() {
        for index in pokeImageArray {
            if pokeImages.count > 0 {
                tileCounter += 1
                let random = arc4random_uniform(UInt32(pokeImages.count))
                index.image = UIImage(named: "\(pokeImages.remove(at: Int(random)))")
                index.layer.borderWidth = 5.0
                index.layer.borderColor = UIColor.black.cgColor
                index.layer.masksToBounds = true
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
    
    // Starts time when play button is pressed.
    func startGameTime() {
        
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    // Updates game time on displays
    @objc func updateCounter () -> String {
        
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
        print(display)
        
        return display
    }
    
    // Function assigns views with tap gestures
    func tapGesture (_ sender: UITapGestureRecognizer) {
        
        // Checks if the user has selected more than 0 cards.
        if selectedTiles.count > 0 {
            
            // if/else statement to deselect a card if the user retaps the same one.
            if sender.view?.description != selectedTiles[0].description {
                selectedTiles.append(sender.view!)
                (sender.view?.subviews[0] as! UIImageView).isHidden = false
            } else {
                // If 2 cards are selected and have different descriptions, the images are hidden.
                keepTiles()
            }
            print("Tapped - No Match")
            
            // If there isn't more than one box in the the array, we have to remove the description check or else that array index will be nil and will cause a crash. We still add the selected box to the array.
        } else {
            selectedTiles.append(sender.view!)
            (sender.view?.subviews[0] as! UIImageView).isHidden = false
            print("Tapped - Image Added to Array")
        }
        
        // If statement to check if 2 cards have been selected.
        if selectedTiles.count == 2 {
            
            // If statement checks subviews to see if they match.
            if (selectedTiles[0].subviews[0] as! UIImageView).image == (selectedTiles[1].subviews[0] as! UIImageView).image {
                (sender.view?.subviews[0] as! UIImageView).isHidden = false
                // Disable user interaction so that they cannot tap any other cards.
                view.isUserInteractionEnabled = false
                
                // Start a timer for .5 second so user can see the match. Calls removeCards function
                timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(removeTiles), userInfo: nil, repeats: false)
                print("Tapped if 2 cards")
            } else {
                (sender.view?.subviews[0] as! UIImageView).isHidden = false
                view.isUserInteractionEnabled = false
                // Start timer for .5 second so user can see images were NOT a match. Calls hideCards function
                timer3 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(keepTiles), userInfo: nil, repeats: false)
                print("Tapped if 2 cards -else")
            }
        }
    }
    
    // Function used to re-hide images when the user does not get a match.
    func keepTiles () {
        
        // Not a match sound
        prepareAudios()
        patSound.play()
        
        for card in selectedTiles {
            card.layer.borderWidth = 2
            card.layer.borderColor = UIColor.yellow.cgColor
            card.backgroundColor = UIColor.black
            (card.subviews[0] as! UIImageView).isHidden = true
        }
        
        // Lose points if tiles are not a match
        gamePoints -= 20
        pointsDisplay.text = "\(gamePoints)"
        
        // Removes the selected boxes from the selected boxes array, allowing the user to start selecting more boxes.
        selectedTiles.removeAll(keepingCapacity: false)
        
        // Renables user interaction.
        view.isUserInteractionEnabled = true
    }
    
    // Function used to hide boxes when the user gets a match.
    func removeTiles () {
        
        // Correct match sound
        prepareAudios()
        chime.play()
        
        for card in selectedTiles {
            card.isHidden = true
        }
        
        // Removes the count of 1 card per selection so we know how many cards are left.
        tileCounter -= 1
        tileCounter -= 1
        
        // Recieve points for matching tiles
        gamePoints += 100
        pointsDisplay.text = "\(gamePoints)"
        
        // Remove selected tiles
        selectedTiles.removeAll(keepingCapacity: false)
        
        // Checks if the number of cards has reached 0.
        if tileCounter == 0 {
            
            // Winning cheers
            prepareAudios()
            tadaSound.play()
            cheering.play()
            
            // Stops the game counter once game is completed.
            timer?.invalidate()
            
            // Reveals the winner's screen.
//            gameView.isHidden = true
//            winnersView.isHidden = false
            
            // Adds the winning text phrase to the winner's screen label.
//            winningTimeText.text! = "You finished in \(display) seconds!"
        }
        
        // Enables the user's interaction once two boxes are matched.
        view.isUserInteractionEnabled = true
    }

    // Function hides images for after the first 5 seconds game preview.
    func seeInitialView(_ sender: UIButton) {
        
        // Enable user interaction to select views
        view.isUserInteractionEnabled = true
        
        // Hides card Image and displays View to now select
        for images in pokeImageArray {
            images.isHidden = true
            print(" 3. Image Hidden - seeInitialView - After Preview")
        }
        
        for view in tileViewArray {
            view.isHidden = false
            print("4. View NOT Hidden - seeInitialView - After Preview")
        }
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        // Button sound
        prepareAudios()
        patSound.play()
        
        // Calls functions
        startGameTime()
        
        // Ensures user can not tap buttons while showing 5 second preview.
        view.isUserInteractionEnabled = false
        
        // Delay images to be shown for 5 seconds.
        self.timer1 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(seeInitialView(_:)), userInfo: nil, repeats: false)
        
        startButton.isHidden = true
        middleView.isHidden = false
        
        // Displays Views and Images for the 5 second preview.
        for views in tileViewArray {
            views.layer.borderWidth = 2
            views.layer.borderColor = UIColor.black.cgColor
            views.isHidden = false
            print(" 1. View NOT Hidden - startButton - Preview")
        }
        
        for images in pokeImageArray {
            images.isHidden = false
            print(" 2. Image NOT Hidden - startButton - Preview")
        }
    }


    // Audio button mutes/unmutes music
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            // pauses music & makes partial transparent
            musicPlayer.pause()
            sender.alpha = 0.2
            
        } else {
            // plays music & makes full view
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
}

