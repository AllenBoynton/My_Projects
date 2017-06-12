//
//  ViewController.swift
//  Boynton_Allen_project1
//
//  Created by Allen Boynton on 10/2/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // Connects table view with storyboard
    @IBOutlet weak var characterView: UITableView!
    
    // Local variables
    var dataArray: [ArrayInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cast1: ArrayInfo = ArrayInfo()
        cast1.character = "Emma Swan"
        cast1.actor = "Jennifer Morrison"
        cast1.description = "Emma is the daughter of Snow White and Prince Charming. Emma is known from all around to be the Savior of all with the purest of hearts and born of true love. She learns she has powerful white magic."
        cast1.image = "Emma"
        
        let cast2: ArrayInfo = ArrayInfo()
        cast2.character = "The Evil Queen"
        cast2.actor = "Lana Parrilla"
        cast2.description = "The Evil Queen, or Regina, in this Realm is searching for her villainous happy ending."
        cast2.image = "Regina"
        
        let cast3: ArrayInfo = ArrayInfo()
        cast3.character = "Henry"
        cast3.actor = "Jared Gilmore"
        cast3.description = "The biological son of Emma Swan and Neal/Baelfire. Henry is the True Believer with a pure heart and hold all of the heroes and villians together."
        cast3.image = "Henry"
        
        let cast4: ArrayInfo = ArrayInfo()
        cast4.character = "Snow White"
        cast4.actor = "Ginnifer Goodwin"
        cast4.description = "From the story of Snow White and the Seven Dwarves is battling for the goodness of her child, Emma Swan."
        cast4.image = "Snow"
        
        let cast5: ArrayInfo = ArrayInfo()
        cast5.character = "Prince Charming"
        cast5.actor = "Josh Dallas"
        cast5.description = "The charming prince that is the true love of Snow White and father to Emma Swan."
        cast5.image = "Charming"
        
        let cast6: ArrayInfo = ArrayInfo()
        cast6.character = "Rumplestiltskin"
        cast6.actor = "Robert Carlyle"
        cast6.description = "Know for the most powerful black magic and a devious fairy tale character known also as The Dark One and Mr. Gold."
        cast6.image = "Rumple"
        
        let cast7: ArrayInfo = ArrayInfo()
        cast7.character = "Belle"
        cast7.actor = "Emilie de Ravin"
        cast7.description = "Right from Beauty and the Beast. Belle has had a long time love for Rumple and will do anything for him, until...."
        cast7.image = "Belle"
        
        let cast8: ArrayInfo = ArrayInfo()
        cast8.character = "Captain Hook"
        cast8.actor = "Colin O'Donoghue"
        cast8.description = "Hook is from Never Never Land and the pirate known with many enemies including Pan and The Crocodile. Is on love with Emma Swan...love!"
        cast8.image = "Hook"
        
        let cast9: ArrayInfo = ArrayInfo()
        cast9.character = "Peter Pan"
        cast9.actor = "Robbie Kay"
        cast9.description = "The devious child that took children from their home to his Never Never Land until he makes the mistake of attempting to take Henry for his pure heart."
        cast9.image = "Peter"
        
        let cast10: ArrayInfo = ArrayInfo()
        cast10.character = "Tinker Bell"
        cast10.actor = "Rose McIver"
        cast10.description = "Tink is twined in with every story here as the fairy to help The Evil Queen find her true love and helps the team get Henry back."
        cast10.image = "Tink"
        
        let cast11: ArrayInfo = ArrayInfo()
        cast11.character = "Robin Hood"
        cast11.actor = "Sean Maguire"
        cast11.description = "Steals from the rich to give to the poor. Until he falls for Regina, The Evil Queen, until things get complicated when his dead wife, Marian returns."
        cast11.image = "RobinHood"
        
        let cast12: ArrayInfo = ArrayInfo()
        cast12.character = "Marian"
        cast12.actor = "Christie Laing"
        cast12.description = "The wife of Robin Hood known to protect Snow White against The Evil Queen. Until  a stranger from the future comes and returns her to this Realm to find her Robin Hood....or does she?"
        cast12.image = "Marian"
        
        let cast13: ArrayInfo = ArrayInfo()
        cast13.character = "Queen Elsa"
        cast13.actor = "Georgina Haig"
        cast13.description = "The beautiful queen from the movie, Frozen. Elsa is on a long journey to do whatever it takes to find her lost sister Ana. With magical powers of snow and ice."
        cast13.image = "Elsa"
        
        let cast14: ArrayInfo = ArrayInfo()
        cast14.character = "Maleficent"
        cast14.actor = "Kristin Bauer van Straten"
        cast14.description = "The evil dragon queen from Sleeping Beauty that seeks vengeance from Rumple and is in search of her child taken from her at birth."
        cast14.image = "Maleficent"
        
        let cast15: ArrayInfo = ArrayInfo()
        cast15.character = "Lily"
        cast15.actor = "Agnes Bruckner"
        cast15.description = "The child of Maleficent taken from her dragon egg before birth. Lily, is harnessing all the darkness taken out of Emma and lives a hard life always searching for that missing part."
        cast15.image = "Lily"
        
        let cast16: ArrayInfo = ArrayInfo()
        cast16.character = "Cruella de Ville"
        cast16.actor = "Victoria Smurfit"
        cast16.description = "Right from 101 Dalmations, Cruella is a villain that is given the power to have control over all animals. Yet, she can not kill a soul."
        cast16.image = "Cruella"
        
        let cast17: ArrayInfo = ArrayInfo()
        cast17.character = "Princess Ursula"
        cast17.actor = "Merrin Dungey"
        cast17.description = "The daughter of King Neptune. She loses the voice of her mother that her father gave to her and seeks vengeance on everyone as an evil Sea Queen with magical tentacles"
        cast17.image = "Ursula"
        
        let cast18: ArrayInfo = ArrayInfo()
        cast18.character = "The Apprentice"
        cast18.actor = "Timothy Webber"
        cast18.description = "The apprentice to the most powerful of all, Merlin. He has the lifelong job to find a new author of the story when it is time. He is also the keeper of the hat!"
        cast18.image = "Apprentice"
        
        let cast19: ArrayInfo = ArrayInfo()
        cast19.character = "The Author"
        cast19.actor = "Isaac Heller"
        cast19.description = "He is one of a long line of writers. Chosen by Merlin and his apprentice to write the story of Once Upon A Time with the use of his magic quill and ink."
        cast19.image = "Author"
        
        let cast20: ArrayInfo = ArrayInfo()
        cast20.character = "Zelena"
        cast20.actor = "Rebecca Mader"
        cast20.description = "The Wicked Witch of West, and long unknown sister of The Evil Queen. She seeks revenge on The Evil Queen when she is the chosen one by Rumple to be the all powerful and is making trouble for eveybody."
        cast20.image = "Zelena"
        
        // Pass in the characters into the storyboard
        dataArray = [cast1, cast2, cast3, cast4, cast5,
                     cast6, cast7, cast8, cast9, cast10,
                     cast11, cast12, cast13, cast14, cast15,
                     cast16, cast17, cast18, cast19, cast20
        ]
        
        for data in dataArray {
            dataArray.append(data)
        }
    }

    
    // Add # of rows to table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    
    // Add labels to the table view section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: LabelTableCell = tableView.dequeueReusableCell(withIdentifier: "MyCell")! as? LabelTableCell {
            
            let currentCharacter: ArrayInfo = dataArray[indexPath.row]
            
            // Uses the local variable array as its return
            cell.characterLabel!.text = currentCharacter.character
            cell.actorLabel!.text = currentCharacter.actor
            cell.myImage!.image = UIImage(named: currentCharacter.image)
            
            return cell
            
        } else {
            
            return LabelTableCell()
        }
    }
    
    
    // Function connects segue from View Controller to Detail View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailView: DetailViewController = segue.destination as! DetailViewController
        
        let indexPath: IndexPath? = characterView.indexPathForSelectedRow
        
        let currentCharacter: ArrayInfo = dataArray[indexPath!.row]
        
        detailView.currentCharacter = currentCharacter
        
    }
    
        
    // Toggle edit button for row deletion
    @IBAction func myToggle(_ sender: UIButton) {
        
        characterView.isEditing = !characterView.isEditing
        
    }
    
    // Allows to edit row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            // This will delete the item from the dataArray
            dataArray.remove(at: indexPath.row)
            
            characterView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}
