//
//  PokeMatchVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/22/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//  Image Source: © Pokémon
//

import UIKit
import AVFoundation
import GameKit

// Protocol to inform the delegate GameVC if a game is over
protocol GameSceneDelegate {
    func showLeaderboard()
    func reportScore(_ score: Int64)
}

class PokeMatchVC: UIViewController {
    
    // Class delegates
    var musicPlayer: AVAudioPlayer!
    
    // Outlet for game points
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsDisplay: UILabel!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var startButton: UIButton!

    // Oulet for timer display
    @IBOutlet weak var timerDisplay: UILabel!
    
    // Outlet Collection for Tile View
    @IBOutlet var pokeButtonArray: [UIButton] = []
    
    // Outlet Collection for Tile Images
//    @IBOutlet var pokeImageArray: [UIImageView] = []
    
    // Local variables - all values change thoughout the game
    
    // Image array
    var pokeImages: [UIImage] = []
    
    // View array of Images selected
    var selectedImages: [UIView] = []
    
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
    var gameOver = Bool()
    
    // Audio player
    var cheering = AVAudioPlayer()
    var tadaSound = AVAudioPlayer()
    var patSound = AVAudioPlayer()
    var chime = AVAudioPlayer()
    var wrongAnswer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize tap gesture
//        for view in tileViewArray {
//            view.isUserInteractionEnabled = true
//            let taps = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
//            view.addGestureRecognizer(taps)
//        }
        
        // Hides card views before game play starts.
        for image in pokeButtonArray {
            image.isHidden = true
            print("View hidden before starting - viewDidLoad")
        }
        
        // Check to see how many buttons are on the screen to determine iPhone or iPad.
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            // iPhone array for 20 buttons
//            for i in 1...718 {
            
            pokeImages = [UIImage(named: "\(1)")!, UIImage(named: "\(2)")!, UIImage(named: "\(3)")!, UIImage(named: "\(4)")!, UIImage(named: "\(5)")!, UIImage(named: "\(6)")!, UIImage(named: "\(7)")!, UIImage(named: "\(8)")!, UIImage(named: "\(9)")!, UIImage(named: "\(10)")!, UIImage(named: "\(1)")!, UIImage(named: "\(2)")!, UIImage(named: "\(3)")!, UIImage(named: "\(4)")!, UIImage(named: "\(5)")!, UIImage(named: "\(6)")!, UIImage(named: "\(7)")!, UIImage(named: "\(8)")!, UIImage(named: "\(9)")!, UIImage(named: "\(10)")!
            ]
                
                print("Image Names: \(pokeImages)")
                print("# of Images: \(pokeImages.count)")
//            }
            // Call function to populate images
            randomImageLoop()
            
        }
//        else if UIDevice.current.userInterfaceIdiom == .pad {
//
//            // iPad array for 30 butons
//            for i in 1...15 {
//                
//                pokeImages = [UIImage(named: "\(i)")!]
//            }
//            randomImageLoop()
//        }
        
//        startGameMusic()
    }
    
    // For in loop to populate array images by removing a random one at a time while array depletes to ensure pairs
    func randomImageLoop() {
        for index in pokeButtonArray {
            if pokeImages.count > 0 {
                tileCounter += 1
                let random = arc4random_uniform(UInt32(pokeImages.count))
                index.setImage(UIImage(named: "\(pokeImages.remove(at: Int(random))))")!, for: .normal)
                index.isHidden = true
                print("Images populating & Images Hidden")
            }
        }
    }
    
    // Sound files
    func prepareAudios() {
        
//        let audioPath1 = Bundle.main.path(forResource: "Cheering", ofType: "mp3")!
//        
//        do {
//            cheering = try AVAudioPlayer(contentsOf: URL(string: audioPath1)!)
//            cheering.prepareToPlay()
//            
//        } catch let err as NSError {
//            
//            print(err.debugDescription)
//        }
//        
//        let audioPath2 = Bundle.main.path(forResource: "taDa", ofType: "mp3")!
//        
//        do {
//            tadaSound = try AVAudioPlayer(contentsOf: URL(string: audioPath2)!)
//            tadaSound.prepareToPlay()
//            
//        } catch let err as NSError {
//            
//            print(err.debugDescription)
//        }
//        
//        let audioPath3 = Bundle.main.path(forResource: "chime", ofType: "mp3")!
//        
//        do {
//            chime = try AVAudioPlayer(contentsOf: URL(string: audioPath3)!)
//            chime.prepareToPlay()
//            
//        } catch let err as NSError {
//            
//            print(err.debugDescription)
//        }
//        
//        let audioPath4 = Bundle.main.path(forResource: "Pat", ofType: "mp3")!
//
//        do {
//            patSound = try AVAudioPlayer(contentsOf: URL(string: audioPath4)!)
//            patSound.prepareToPlay()
//            
//        } catch let err as NSError {
//            
//            print(err.debugDescription)
//        }
    }
    
    // Create function to initiate music playing when game begins
    func startGameMusic() {
        
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
    @objc func updateCounter() -> String {
        
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
//        print(display)
        
        return display
    }
    
    // Function assigns views with tap gestures
    func tapGesture(_ sender: UITapGestureRecognizer) {
    
        // Checks if the user has selected more than 0 cards.
        if selectedImages.count > 0 {
            
            // if/else statement to deselect a card if the user retaps the same one.
            if sender.view?.description != selectedImages[0].description {
//                selectedImages.append(<#UIView#>)
                (sender.view?.subviews[0] as! UIImageView).isHidden = false
            } else {
                // If 2 cards are selected and have different descriptions, the images are hidden.
                keepTiles()
            }
            print("Tapped - No Match")
            
            // If there isn't more than one box in the the array, we have to remove the description check or else that array index will be nil and will cause a crash. We still add the selected box to the array.
        } else {
//            selectedImages.append(UIImage)
            (sender.view?.subviews[0] as! UIImageView).isHidden = false
            print("Tapped - Image Added to Array")
        }
        
        // If statement to check if 2 cards have been selected.
        if selectedImages.count == 2 {
            
            // If statement checks subviews to see if they match.
            if (selectedImages[0].subviews[0] as! UIImageView).image == (selectedImages[1].subviews[0] as! UIImageView).image {
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
    func keepTiles() {
        
        // Remove points for missing match
        gamePoints -= 20
        
        // Not a match sound
        prepareAudios()
//        patSound.play()
        
        for tile in selectedImages {
            tile.layer.borderWidth = 2.0
            tile.layer.borderColor = UIColor.yellow.cgColor
            tile.backgroundColor = UIColor.black
            (tile.subviews[0] as! UIImageView).isHidden = true
        }
        
        // Removes the selected boxes from the selected boxes array, allowing the user to start selecting more boxes.
        selectedImages.removeAll(keepingCapacity: false)
        
        // Renables user interaction.
        view.isUserInteractionEnabled = true
    }
    
    // Function used to hide boxes when the user gets a match.
    func removeTiles() {
        
        // 1. Replace the image with a blank one
        // 2. Use the alpha on an image to hide it

        
        // Add points for a match
        gamePoints += 100
        
        // Correct match sound
        prepareAudios()
//        chime.play()
        
//        for image in pokeImageArray {
//            image.isHidden = true
//        }
        
        for tile in selectedImages {
            tile.layer.backgroundColor = UIColor.clear.cgColor
            tile.layer.borderWidth = 0
        }
        
        // Removes the count of 1 card per selection so we know how many cards are left.
        tileCounter -= 1
        tileCounter -= 1
        
        selectedImages.removeAll(keepingCapacity: false)
        
        // Checks if the number of cards has reached 0.
        if tileCounter == 0 {
            
            // Winning cheers
            prepareAudios()
//            tadaSound.play()
//            cheering.play()
            
            // Stops the game counter once game is completed.
            timer?.invalidate()
            
            // Reveals the winner's screen
            gameOver = true
            
//            gameView.isHidden = true
//            winnersView.isHidden = false
//            
//            // Adds the winning text phrase to the winner's screen label.
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
        for images in pokeButtonArray {
            images.backgroundImage(for: .disabled)
//            images.isHidden = true
            print(" 3. Image Hidden - seeInitialView - After Preview")
        }
        
        for view in pokeButtonArray {
            view.backgroundImage(for: .normal)
//            view.isHidden = false
            print("4. View NOT Hidden - seeInitialView - After Preview")
        }
    }
    @IBAction func pokeButtonPressed(_ sender: RoundedButtons) {
        
        
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        
        // Button sound
        prepareAudios()
//        patSound.play()
        
        // Calls functions
        startGameTime()
        
        // Ensures user can not tap buttons while showing 5 second preview.
        view.isUserInteractionEnabled = false
        
        // Delay images to be shown for 5 seconds.
        self.timer1 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(seeInitialView(_:)), userInfo: nil, repeats: false)
        
        // Shows button at beginning of game
        startButton.isHidden = true
        
        // Unhides views after start button is pressed
        pointsView.isHidden = false
        middleView.isHidden = false
        bottomView.isHidden = false
        
        // Displays Views and Images for the 5 second preview.
        for views in pokeButtonArray {
//            views.layer.borderWidth = 2.0
//            views.layer.borderColor = UIColor.yellow.cgColor
            views.image(for: .normal)
            print(" 1. View NOT Hidden - startButton - Preview")
        }
        
//        for images in pokeButtonArray {
//            images.isHidden = false
//            print(" 2. Image NOT Hidden - startButton - Preview")
//        }
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
    
    // Back button to bring to main menu
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        timer?.invalidate()
    }
    
}

//// iPad array for 30 buttons
//pokeImages = [
//    "military chainsaw.png", "tools rope.png", "tools saw.png",
//    "tools screwdriver.png", "tools shovel.png", "tools swiss knife.png",
//    "tools torch.png", "tools wrench.png", "weapons gaunlets.png",
//    "weapons katana.png", "magic wizard hat.png", "weapons medieval helmet.png",
//    "weapons medieval sword.png", "weapons sledgehammer.png", "weapons wood shield.png",
//    "military chainsaw.png", "tools rope.png", "tools saw.png",
//    "tools screwdriver.png", "tools shovel.png", "tools swiss knife.png",
//    "tools torch.png", "tools wrench.png", "weapons gaunlets.png",
//    "weapons katana.png", "magic wizard hat.png", "weapons medieval helmet.png",
//    "weapons medieval sword.png", "weapons sledgehammer.png", "weapons wood shield.png"
//]

//            [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "11")!, UIImage(named: "12")!, UIImage(named: "13")!, UIImage(named: "14")!, UIImage(named: "15")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "10")!, UIImage(named: "11")!, UIImage(named: "12")!, UIImage(named: "13")!, UIImage(named: "14")!, UIImage(named: "15")!
//            ]
