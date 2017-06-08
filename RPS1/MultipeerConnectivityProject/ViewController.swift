//
//  ViewController.swift
//  MultipeerConnectivityProject
//
//  Created by Allen Boynton on 5/17/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate, UITextFieldDelegate {

    // MARK: - Properties
    
    // Outlets for storyboard background holders
    @IBOutlet weak var signInBackground: UIView! //
    @IBOutlet weak var gameBoardBackground: UIView! //
    
    // Outlets for play button to signin and then to continue to game
    @IBOutlet weak var playGameButton: UIButton!
    @IBOutlet weak var changeUserButton: UIButton! //
    @IBOutlet weak var quitButton: UIButton! //
    
    // Outlet collection for nav bar buttons - (Friends/Play)
    @IBOutlet weak var navBarText: UINavigationBar!
    @IBOutlet weak var friendSearch: UIBarButtonItem! //
    @IBOutlet weak var playNowButton: UIBarButtonItem! //
    
    // Outlets for 3 RPS buttons
    @IBOutlet weak var rockButton: UIButton! //
    @IBOutlet weak var paperButton: UIButton! //
    @IBOutlet weak var scissorsButton: UIButton! //
    
    // Outlets for the user's name and score
    @IBOutlet weak var player1Name: UILabel! //
    @IBOutlet weak var player2Name: UILabel! //
    @IBOutlet weak var score1: UILabel! //
    @IBOutlet weak var score2: UILabel! //
    
    // Outlet in order to reveal and hide labels.
    @IBOutlet weak var nameQuestion: UILabel! //
    @IBOutlet weak var opponentIsReady: UILabel! //
    @IBOutlet weak var pleaseConnect: UILabel! //
    @IBOutlet weak var opponentIsReady2: UILabel! //
    
    // Outlet collection for the countdown sequence
    @IBOutlet weak var second3Label: UILabel! //
    @IBOutlet weak var second2Label: UILabel! //
    @IBOutlet weak var second1Label: UILabel! //
    @IBOutlet weak var shootLabel: UILabel! //
    @IBOutlet weak var winnerLabel: UILabel! //
    
    // Outlets for images that contain each user's choice.
    @IBOutlet weak var user1PickedImage: UIImageView! //
    @IBOutlet weak var user2PickedImage: UIImageView! //
    
    // MC outlets for communication P2P
    @IBOutlet weak var displayText: UITextView!
    @IBOutlet weak var messageView: UITextView! //
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    /* The Four Main Building Blocks To a Multipeer App */
    var peerID: MCPeerID! // Our device's ID or name as viewed by other "browsing" devices.
    var session: MCSession! // ~The "Connection" between devices.
    var browser: MCBrowserViewController! // Prebuilt ViewController that searches for nearby advertiser.
    var advertiser: MCAdvertiserAssistant! // Helps us easily advertise ourselves to nearby browsers.
    
    let serviceID = "RPS-boynton" // "Channel"
    

    // This stores the opponent's peerId.displayname.
    var player2NameHolder = ""
    var userNameHolder = ""
    
    // These store players picks.
    var usersPick = ""
    var player2Pick = ""
    
    // These variables track both users' ready status.
    var userStatus = "false"
    var player2Status = "false"
    
    // These ints track both users' scores.
    var userIntPoints = 0
    var player2IntPoints = 0
    
    // Local properties for use with the countdown timer
    var count = 4
    var timer = NSTimer()
    
    // Aesthetic attribute variables to use colors/shape in button borders
    var color: CABasicAnimation? = nil
    
    // Tag of image for users pick
    var tagForRPS: Int = 0
    

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Setup our MC objects - added a settings button to change my peerID
        peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        messageView?.text = "Hello, \(inputField.text!)!"
        
        // Use PeerID to setup session - can use methods to make more secure
        session = MCSession(peer: peerID)
        session.delegate = self
        
        // Setup and start advertising immediately
        advertiser = MCAdvertiserAssistant(serviceType: serviceID, discoveryInfo: nil, session: session)
        advertiser.start()
        
        // Verify to clear text views of all previous text
        messageView?.text = nil
        
        // Text field delegate to work with dismissing the keyboard
        inputField?.delegate = self
        
        // I had no choice to use optionals here. I tried optional binding but error told me does not conform to protocol 'SequenceType'.
        pleaseConnect?.layer.cornerRadius = 6
        pleaseConnect?.layer.borderWidth = 2
        pleaseConnect?.layer.borderColor = UIColor.redColor().CGColor
        
        opponentIsReady?.layer.cornerRadius = 6
        opponentIsReady?.layer.borderWidth = 2
        opponentIsReady?.layer.borderColor = UIColor.redColor().CGColor
        
        inputField?.layer.cornerRadius = 6
        inputField?.layer.borderWidth = 2
        inputField?.layer.borderColor = UIColor.blackColor().CGColor
        
        // Buttons needed to have font size adjust for the width programatically + attributes.
        playGameButton?.titleLabel!.adjustsFontSizeToFitWidth = true
        
        enterButton?.titleLabel!.numberOfLines = 1
        enterButton?.titleLabel!.adjustsFontSizeToFitWidth = true
        enterButton?.layer.cornerRadius = 6
        enterButton?.layer.borderWidth = 2
        enterButton?.layer.borderColor = UIColor.blackColor().CGColor
        
        changeUserButton?.titleLabel!.numberOfLines = 1
        changeUserButton?.titleLabel!.adjustsFontSizeToFitWidth = true
        changeUserButton?.layer.cornerRadius = 6
        changeUserButton?.layer.borderWidth = 2
        changeUserButton?.layer.borderColor = UIColor.blackColor().CGColor
        
        opponentIsReady2?.layer.cornerRadius = 6
        opponentIsReady2?.layer.borderWidth = 2
        opponentIsReady2?.layer.borderColor = UIColor.redColor().CGColor
        
        user1PickedImage?.layer.cornerRadius = 6
        user1PickedImage?.layer.borderWidth = 2
        user1PickedImage?.layer.borderColor = UIColor.redColor().CGColor
        
        user2PickedImage?.layer.cornerRadius = 6
        user2PickedImage?.layer.borderWidth = 2
        user2PickedImage?.layer.borderColor = UIColor.redColor().CGColor
        
        quitButton?.layer.cornerRadius = 6
        quitButton?.layer.borderWidth = 2
        quitButton?.layer.borderColor = UIColor.blackColor().CGColor
        
        
        // Adjust Nav bar text to fit status changes
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 12)!]
        
        // Adjust bar button items to a proper size and font
        if let font = UIFont(name: "Helvetica Neue", size: 15) {
            friendSearch?.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        }
        
        if let font = UIFont(name: "Helvetica Neue", size: 15) {
            playNowButton?.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        }
        
        // Adjust Nav bar text to fit status changes
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica", size: 13)!]
    }
    
        
    // MARK: - Functions for game play
    
    // Create alert to instruct user what to do in game screen
    func instructionAlert() -> Bool {
        
        if friendSearch.enabled == true {
            
            let alertUser = UIAlertController(title: "Attention", message: "To start, first tap the \"Connect\" button to search for a local opponent. Once chosen and confirmed, you may then tap the \"Play Now\" button to start your game. Have fun!!", preferredStyle: UIAlertControllerStyle.Alert)
            
            let acceptButton = UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil)
            
            alertUser.addAction(acceptButton)
            
            presentViewController(alertUser, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    // Use animation to highlight borders on looped RPS buttons
    func highlightButtons() {
        
        let buttonArray = [rockButton, paperButton, scissorsButton]
        
        let color: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
            color.fromValue = UIColor.redColor().CGColor
            color.toValue = UIColor.whiteColor().CGColor
            color.duration = 1.0
            color.autoreverses = true
        
        for choiceButton in buttonArray {
            choiceButton.layer.borderColor = UIColor.redColor().CGColor
            choiceButton.layer.addAnimation(color, forKey: "")
            choiceButton.layer.cornerRadius = 6
            choiceButton.layer.borderWidth = 2
            choiceButton.layer.borderColor = UIColor.whiteColor().CGColor
        }
    }

    
    // MARK: - Lets Play Now function
    
    // Funtion to start the game play with player 2.
    func playNow() {
        
        // Change out sign in screen for game screen
        signInBackground.hidden = true
        gameBoardBackground.hidden = false
        
        // Changes the userName text underneath the user's score to their name.
        player1Name.text = peerID.displayName
        
        // Here we change the opponent name under the score to match the connected peer.
        player2Name.text = "\(player2NameHolder)"
        
        // Display players scores
        score1.hidden = false
        score2.hidden = false
        
        // Disable the search button
        friendSearch.enabled = false
        
        // These reset the users' choices.
        usersPick = ""
        player2Pick = ""
        
        // These clear the images that the users is to choose.
        user1PickedImage.image = nil
        user2PickedImage.image = nil
        
        // Starts the countdown timer.
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.shootTimer), userInfo: nil, repeats: true)
    }
    
    // MARK: - Countdown Function
    
    /// Creating this switch statement function displays the 3-2-1-SHOOT! for the game.
    func shootTimer() {
        
        winnerLabel.hidden = true
        
        switch count {
            
        case 4:
            second3Label.hidden = false
            count -= 1
        case 3:
            second2Label.hidden = false
            count -= 1
        case 2:
            second1Label.hidden = false
            count -= 1
        case 1:
            second3Label.hidden = true
            second2Label.hidden = true
            second1Label.hidden = true
            shootLabel.hidden = false
            count -= 1
        case 0:
            shootLabel.text = "SHOOT!!"
            
            // These hide all the countdown items
            second3Label.hidden = true
            second2Label.hidden = true
            second1Label.hidden = true
            shootLabel.hidden = true
            
            user1PickedImage.hidden = false
            user2PickedImage.hidden = false
            winnerLabel.hidden = false
            
            // This converts text to NSData object to sent our pick to player 2 through MC.
            if let data = usersPick.dataUsingEncoding(NSUTF8StringEncoding) {
                
                // Needs a do/catch statement to allow to run with chance of error (try)
                do {
                    try session.sendData(data, toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
                    
                } catch {
                    print("Error: Send Data Failed after timer and do/try attempt.")
                }
            }
            timer.invalidate()
            count = 4
            
        default:
            print("Where's the time?")
        }
    }
    
    
    // MARK: - Decide Winner Function
    
    /// This is called when the countdown is totally finished and both users have received data from each other.
    func pickAWinner () {
        
        // Disable the character buttons
        rockButton.enabled = false
        paperButton.enabled = false
        scissorsButton.enabled = false
        
        // Created a switch statement for Player 2's pick.
        switch player2Pick {
        case "Rock":
            // Player 2 chose this image.
            self.user2PickedImage.image = UIImage(named: "Rock")
            
            // If statement that checks the user's own choice and determines if the round was a tie, if the user won, or if the user lost.
            if usersPick == "Rock" {
                winnerLabel.text = "Tie!"
            }
            else if usersPick == "Paper" {
                winnerLabel.text = "Winner!!"
                userIntPoints += 1
                score1.text = String(userIntPoints)
                score2.text = String(player2IntPoints)
            }
            else if usersPick == "Scissors" {
                winnerLabel.text = "Loser!"
                player2IntPoints += 1
                score2.text = String(player2IntPoints)
                score1.text = String(userIntPoints)
            }
            // If the user doesn't make a choice, we punish them for it.
            else if usersPick == "" {
                winnerLabel.text = "Too Slow..."
                player2IntPoints += 1
                score2.text = String(player2IntPoints)
                score1.text = String(userIntPoints)
            }
            
        case "Paper":
            self.user2PickedImage.image = UIImage(named: "Paper")
            
            if usersPick == "Rock" {
                winnerLabel.text = "Loser!"
                player2IntPoints += 1
                score2.text = String(player2IntPoints)
            }
            else if usersPick == "Paper" {
                winnerLabel.text = "Tie!"
            }
            else if usersPick == "Scissors" {
                winnerLabel.text = "Winner!!"
                userIntPoints += 1
                score1.text = String(userIntPoints)
            }
            else if usersPick == "" {
                winnerLabel.text = "Too Slow..."
                player2IntPoints += 1
                score2.text = String(player2IntPoints)
            }
            
        case "Scissors":
            self.user2PickedImage.image = UIImage(named: "Scissors")
            
            if usersPick == "Rock" {
                winnerLabel.text = "Winner!!"
                userIntPoints += 1
                score1.text = String(userIntPoints)
            }
            else if usersPick == "Paper" {
                winnerLabel.text = "Loser!"
                player2IntPoints += 1
                score2.text = String(player2IntPoints)
            }
            else if usersPick == "Scissors" {
                winnerLabel.text = "Tie!"
            }
            else if usersPick == "" {
                winnerLabel.text = "Too Slow..."
                player2IntPoints += 1
                score2.text = String(player2IntPoints)
            }
            
        default:
            print("Replay")
        }
        
        // This resets the game played and enables the next game.
        userStatus = "false"
        player2Status = "false"
        
        // Enable play button for another game.
        playNowButton.enabled = true
    }

    
    // MARK - IBActions and functions called within
    
    // Brings us to the sign in screen to give a player name, then connect, then play.
    @IBAction func playAFriendButton(sender: UIButton) {
        
        // Hide and unhide views for sign in board. Safety for storyboard settings.
        gameBoardBackground?.hidden = true
        signInBackground?.hidden = false
        
        // Disable buttons
        friendSearch?.enabled = false
        playNowButton?.enabled = false
    }
    
    // This function of this button is to continue to the game screen.
    @IBAction func enterButton(sender: UIButton) {
        
        // Adding text field to enter opponent's name and give greeting.
        messageView.text = "Hello \(inputField.text!)!"
        displayText.text = "Thank you for playing! Now just tap the \"Friends\" button in the upper left corner to find a friend to play."
        
        // Clear out text field
        inputField.text = nil
        
        // Hide and reveal elements and get ready to continue to start.
        messageView.hidden = false
        displayText.hidden = false
        changeUserButton.hidden = true
        
        friendSearch.enabled = true
        playNowButton.enabled = false
        
        // Alert user to simple initial instructions via Alert.
        instructionAlert()
    }

    // Created button to connect to the MC
    @IBAction func friendSearchButton(sender: UIBarButtonItem) {
        
        // Check if already connected
        if session != nil {
            
            // Our browser will look for advertisers on same serviceID.
            browser = MCBrowserViewController(serviceType: serviceID, session: session)
            
            browser.delegate = self
            
            self.presentViewController(browser, animated: true, completion: nil)
        }
        
        // Disable friend search button and enable play now.
        friendSearch.enabled = false
        playNowButton.enabled = true
        
        messageView.hidden = false
        displayText.hidden = false
        
        // Retrieve name entered in text field
        userNameHolder = inputField.text!
        
        // Inform users of next steps.
        messageView.text = "Hello \(userNameHolder)!"
        displayText.text = "You are now connected to: \(peerID.displayName). You can tap the \"Play Now\" in the upper right to play a match. When you are both ready, you will go to the game screen and have 3 seconds to pick your choice."
        
        changeUserButton.hidden = false
    }
    
    // Action opens the game screen and reveals and hides accordingly.
    @IBAction func playNowButton(sender: UIBarButtonItem) {
        
        // Play button is disabled once a game is in the works. Then enables to play next game.
        playNowButton.enabled = false
        
        // Disable the winner/loser label
        winnerLabel.hidden = true
        
        // Enable character buttons
        rockButton.enabled = true
        paperButton.enabled = true
        scissorsButton.enabled = true
        
        // Animates border to attract attention to buttons.
        highlightButtons()
        
        // Set's the user's ready status to true.
        userStatus = "true"
        
        // Sends the ready status of this user to their opponent.
        if let data = userStatus.dataUsingEncoding(NSUTF8StringEncoding) {
            
            // Needs a do/catch statement to allow to run with chance of error (try)
            do {
                // This converts text to NSData object to sent through MC
                try session.sendData(data, toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
                
            } catch {
                print("Error: Send user's ready status to opponent FAILED.")
            }
        }
        
        // If both players have tapped Play now, they are ready and game has begun.
        if userStatus == "true" && player2Status == "true" {
            
            playNowButton.enabled = true
            
            // Now both players are ready and we can call the playNow function.
            playNow()
        }
    }
    
    // Assigns buttons tags and their names to the images.
    @IBAction func gameButtonsRPS(sender: UIButton) {
        
        // So images aren't seen until countdown is through.
        user1PickedImage.hidden = true
        user2PickedImage.hidden = true
        
        // Variable for tags on buttons.
        tagForRPS = sender.tag
        
        switch tagForRPS {
        case 1:
            // Users saved pick of RPS and then display image.
            usersPick = "Rock"
            user1PickedImage.image = UIImage(named: "Rock")
        case 2:
            usersPick = "Paper"
            user1PickedImage.image = UIImage(named: "Paper")
        case 3:
            usersPick = "Scissors"
            user1PickedImage.image = UIImage(named: "Scissors")
        default:
            print("User did not pick in time.")
        }
        // Call funtion to enter choice into switch and if/else statements to reveal the winner.
        pickAWinner()
        
        print("Player 1 picked: \(usersPick).")
    }
    
    // User is able to change their player name with this settings button.
    @IBAction func changePlayerName(sender: UIButton) {
        
        // Disconnect from MC
        session.disconnect()
        self.advertiser.stop()
        
        // Hide and reveal elements to continue to play with a different name.
        messageView.hidden = true
        displayText.hidden = true
        nameQuestion.hidden = false
        enterButton.hidden = false
        inputField.hidden = false
    }
    
    // Action will disconnect from the session. Needed an escape!!
    @IBAction func disconnect(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        session.disconnect()
        advertiser.start()
    }
    
    
    // MARK: - UITextFieldDelegate
    
    // Dismises the keyboard when send is tapped.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Hides the keyboard when the screen is touched.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    // MARK: - MCBrowserViewControllerDelegate
    
    // Notifies the delegate, when the user taps the done button.
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Notifies delegate that the user taps the cancel button.
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    

    // MARK: - MCSessionDelegate Controls the session
    
    // Remote peer changed state - connects, disconnects, etc.
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
        /* This whole callback happens in a background thread*/
        dispatch_async(dispatch_get_main_queue(), {
            if state == MCSessionState.Connected {
                
                // Connection statuses by if/else statements
                if session.connectedPeers.count == 1 {
                    
                    // Created to stop advertising once connected with a player.
                    self.advertiser.stop()
                    
                    // Displays to the user if the other player is ready
                    self.pleaseConnect?.text = "Connected to: \(peerID.displayName)."
                    
                    self.opponentIsReady2?.text = "\(peerID.displayName) is not ready."
                    
                    // Now that we have an opponent, we enable the ready to play button.
                    self.friendSearch?.enabled = false
                    self.playNowButton?.enabled = true
                }
                
            } else if state == MCSessionState.Connecting {
                self.pleaseConnect?.text = "Connecting to opponent..."
                
            } else if state == MCSessionState.NotConnected {
                self.pleaseConnect?.text = "Status: No Connection"
                
                // Allows to try to connect again after failing.
                // Reveal message view for info.
                self.messageView?.hidden = false
                self.displayText?.hidden = false
                self.messageView?.text = "Hello \(self.player2NameHolder)"
                self.displayText?.text = "Search for a friend to play! Just tap the \"Friends\" button in the upper left."
                
                self.playNowButton?.enabled = false
                self.friendSearch?.enabled = true
                self.quitButton?.enabled = false
                
                // Game stats to get values of the scores.
                self.userIntPoints = 0
                self.player2IntPoints = 0
                self.score1?.text = "0"
                self.score2?.text = "0"
                self.score1?.hidden = false
                self.score2?.hidden = false
                
                // Hide and reveal more displays
                self.gameBoardBackground?.hidden = true
                self.signInBackground?.hidden = false
                self.messageView?.hidden = true
                self.player1Name?.hidden = false
                self.player2Name?.hidden = false
                
            } else {
                fatalError("ERROR: RPS has stopped.")
            }})
    }
    
    // Received data from remote peer.
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
        // Build a new String from the encoded NSData Object - Unencoding
        if let data: String = String(data: data, encoding: NSUTF8StringEncoding) {
            
            // Here we check if that info true or data is ready.
            if data == "true" {
                
                // UI info goes on the Main Thread.
                dispatch_async(dispatch_get_main_queue(), {
                    
                    // Captures peerID name
                    self.player2NameHolder = peerID.displayName
                    self.opponentIsReady2?.text = "\(self.player2NameHolder) is ready!"
                    self.player2Status = "true"
                    self.user2PickedImage?.hidden = true
                    
                    // Now we check if both users are ready to play, and if they are we run the readyup function. If not, we will check again when we send data to the other user.
                    if self.player2Status == "true" && self.userStatus == "true" {
                        
                        self.user1PickedImage.hidden = true
                        self.user2PickedImage.hidden = true
                        self.playNow()
                    }
                })
                
                // Opponent is not ready and has not connected or not tapped play.
            } else {
                
                self.user2PickedImage?.hidden = true
                
                // Created a switch statement to check if the opponent chose rock, paper, or scissors.
                switch data {
                case "Rock":
                    
                    // This stores the opponent's pick and then dispatches to the main thread to decide a winner.
                    self.player2Pick = "Rock"
                    dispatch_async(dispatch_get_main_queue(), {
                        self.pickAWinner()
                    })
                case "Paper":
                    self.player2Pick = "Paper"
                    dispatch_async(dispatch_get_main_queue(), {
                        self.pickAWinner()
                    })
                case "Scissors":
                    self.player2Pick = "Scissors"
                    dispatch_async(dispatch_get_main_queue(), {
                        self.pickAWinner()
                    })
                case "":
                    // If/else if the opponent chose nothing before time ran out. Then the opponent gets a point.
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.winnerLabel?.hidden = false
                        
                        if self.usersPick == "" {
                            self.winnerLabel?.text = "No one chose."
                            self.userStatus = "false"
                            self.player2Status = "false"
                            self.playNowButton?.enabled = true
                        } else {
                            self.winnerLabel?.text = "They didn't choose."
                            self.userStatus = "false"
                            self.player2Status = "false"
                            self.playNowButton?.enabled = true
                        }
                    })
                    
                default:
                    print("No data received.")
                }                
                print("Player 2 picked: \(player2Pick).")
                
                // Change the statuses back to false so the users can replay.
                dispatch_async(dispatch_get_main_queue(), {
                    self.player2NameHolder = peerID.displayName
                    self.opponentIsReady2?.text = "\(self.player2NameHolder) is not ready."
                    self.player2Status = "false"
                })
            }
        }
    }
    // Received a byte stream from remote peer.
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    // Start receiving a resource from remote peer.
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {}
    
    // Finished receiving a resource from remote peer and saved the content in a temporary location
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {}
}
