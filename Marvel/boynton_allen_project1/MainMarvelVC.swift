//
//  MainMarvelVC.swift
//  Marvel
//
//  Created by Allen Boynton on 10/27/15.
//  Copyright © 2015 Allen Boynton. All rights reserved.
//

import UIKit

// Global Indentifiers
let heroCell = "MyCell"

class MainMarvelVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Create IB Outlet for cell table view
    @IBOutlet weak var tableView: UITableView!
    
    // Local variables
    var dataArray: [ArrayInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Array information for the superhero theme
        let hero1: ArrayInfo = ArrayInfo()
        hero1.title = "Spider-Man"
        hero1.subtitle = "Peter Parker"
        hero1.detail = "The culmination of nearly every superhero that came before him, Spider-Man is the hero of heroes. He’s got fun and cool powers, but not on the god-like level of Thor. He’s just a normal guy with girlfriend problems and money issues, so he’s more relatable than playboy billionaire Iron Man. And he’s an awkward teenager, not a wizened adult like Captain America. Not too hot and not too cold, Spider-Man is just right."
        hero1.image = "Spiderman"
        
        let hero2: ArrayInfo = ArrayInfo()
        hero2.title = "The Hulk"
        hero2.subtitle = "Bruce Banner"
        hero2.detail = "If Hulk is the strongest one their is, we're lucky he's on our side. A Jekyll and Hyde tale done with superpowers, Bruce Banner's alter-ego is surprisingly relatable once you get past his towering stature and green skin. The result of a gamma bomb test gone wrong, Hulk has long been the target of many evil and malicious plots looking to exploit his power. Yet no matter how many times he's attacked, coerced, or shot into space, he's always ready and willing to defend his planet at a moments notice. He may not always be one to play well with others, but when you need something smashed, Hulk is your guy."
        hero2.image = "Hulk"
        
        let hero3: ArrayInfo = ArrayInfo()
        hero3.title = "Iron Man"
        hero3.subtitle = "Tony Stark"
        hero3.detail = "Tony Stark is many things -- genius, billionaire, playboy, philanthropist -- but as Iron Man he represents something more.. A brush with death lead to the creation of his first armor, and since that time he has used his vast wealth to fund the Avengers. Iron Man is a hero for his continued bravery in the face of danger. Beneath the nuts and bolts and repulsor rays lies a man of flesh and blood, willingly rocketing himself into harm without a second thought -- against villains with actual superpowers! While far from flawless, Iron Man always uses his superior intellect to try and make the world a better place."
        hero3.image = "Ironman"
        
        let hero4: ArrayInfo = ArrayInfo()
        hero4.title = "Wolverine"
        hero4.subtitle = "James Logan Howlett"
        hero4.detail = "Wolverine is an X-Man, an Avenger, and a champion to young mutants fighting to survive in a world that hates and fears them. With a healing factor and an unbreakable adamantium skeleton, he’s virtually immortal, and he uses his gifts to fight all manner of evil villains and personal demons from his past. What sets him apart as a hero is his willingness to cross the line. He takes the burden from others and puts it on his already-heavy shoulders, doing whatever it takes to save the day. He’s the best at what he does, and with three razor-sharp claws on each hand, it’s plain to see what that is."
        hero4.image = "Wolverine"
        
        let hero5: ArrayInfo = ArrayInfo()
        hero5.title = "Captain America"
        hero5.subtitle = "Steven \"Steve\" Rogers"
        hero5.detail = "Though he may fight wearing the red, white, and blue of America, Cap would stand up for anybody in need of a hero. He grew up as a weakling with a heart of gold, so when a super-soldier serum transformed him into a man at the peak of human potential -- big muscles, astounding agility, unbelievable endurance -- he was finally able to put that strong moral compass of his to good use. He’s socked Hitler in the face, stopped the Red Skull’s most nefarious plans, and even stood up to Iron Man’s Superhero Registration Act during the Marvel Civil War."
        hero5.image = "Captain_America"
        
        let hero6: ArrayInfo = ArrayInfo()
        hero6.title = "Thor"
        hero6.subtitle = "God of Thunder"
        hero6.detail = "There’s no questioning Thor’s place amongst the elite pantheon of Marvel heroes. The son of Odin and heir to Asgard, Thor has long been a champion of the downtrodden, whether he’s smashing frost giants on Jotunheim or battling alongside the Avengers on Midgard. Possessor of the mighty Mjolnir, a magic hammer of devastating power, Thor’s remarkable strength is outshone only by his unwavering belief in humanity. The first into battle and the last to leave, this founding Avenger will let nothing get in his way when it comes to protecting the innocent. And if something does get in his way, well, that's what the hammer is for."
        hero6.image = "Thor"
        
        let hero7: ArrayInfo = ArrayInfo()
        hero7.title = "Silver Surfer"
        hero7.subtitle = "Norinn Radd"
        hero7.detail = "Forced into servitude to protect his people from harm, Norinn Radd scoured the galaxy as the Silver Surfer in search of sustenance for his master, Galactus. Bestowed with Galactus' own energy, the Power Cosmic, and given a surfboard for which to ride the stars, the Surfer's hunt eventually lead to an encounter with the Fantastic Four on Earth. Moved by their plight, the herald turned on his master in a show of bravery, refusing to allow yet another planet to die for the sake of his own. Since then the Surfer has used the Power Cosmic for good, riding the cosmos in search of further injustice to fight."
        hero7.image = "Silver_Surfer"
        
        let hero8: ArrayInfo = ArrayInfo()
        hero8.title = "Daredevil"
        hero8.subtitle = "Matt Murdock"
        hero8.detail = "Matt Murdock grew up idolizing his father, boxer “Battling” Jack Murdock, before having his sight taken from him by a chemical spill. The accident granted him super-enhanced senses, letting him “see” the world around him with a radar-like ability. After his father was murdered for not throwing a fight, Matt became a crime-opposing lawyer by day and crime-punching red ninja by night. Daredevil defends Hell’s Kitchen from the Hand, the Kingpin, Bullseye, and all manner of thugs and crooks."
        hero8.image = "Daredevil"
        
        let hero9: ArrayInfo = ArrayInfo()
        hero9.title = "Elektra"
        hero9.subtitle = "Elektra Natchios"
        hero9.detail = "Elektra reacts to the death of her father by seeking revenge, dropping out of university and traveling to China to study in martial arts. She joins the martial arts organization known as the Chaste and she receives training from Stick, but she is eventually corrupted by her own impulses and instead joins the Hand, a group of ninja like assassins. Eventually she too breaks free of their control and becomes an assassin in her own right."
        hero9.image = "Elektra"
        
        let hero10: ArrayInfo = ArrayInfo()
        hero10.title = "Cyclops"
        hero10.subtitle = "Scott Summers"
        hero10.detail = "The first of Charles Xavier's X-Men, Scott Summers is known as much for his serious personality as he is his powerful optic blasts. Rescued by Xavier and hand picked to lead the team's first incarnation of heroes, the mutant known as Cyclops is the epitome of selflessness, proving time and again that good leaders lead through example. While he may not be as interesting as his more colorful counterparts, his skills as a tactician are equal to none. Recent events have arguably seen Cyclops fall from grace, but the fact remains that every decision he makes, good or bad, is made for the betterment of mutantkind."
        hero10.image = "Cyclops"
        
        let hero11: ArrayInfo = ArrayInfo()
        hero11.title = "Doctor Strange"
        hero11.subtitle = "Doctor Stephen Vincent Strange"
        hero11.detail = "In a world where the impossible is commonplace, it pays to have a Sorcerer Supreme on your side. An arrogant surgeon humbled by his quest to heal his injured hands, Stephen Strange became the world’s foremost authority on all things supernatural. As the Sorcerer Supreme known as Doctor Strange, he’s often seen teaming up with other heroes, banishing demons, and saying things like “By the Hoary Hosts of Hoggoth” – whatever that means."
        hero11.image = "Doctor_Strange"
        
        let hero12: ArrayInfo = ArrayInfo()
        hero12.title = "Punisher"
        hero12.subtitle = "Frank Castle"
        hero12.detail = "After his family was killed by the mob, Marine Special Forces veteran Frank Castle became an army of one in his war against organized crime. With a distinct death's-head symbol emblazoned on his chest, he is now the vigilante known as The Punisher. Not only vowed to have revenge for his family, but also to dedicate the rest of his life to fighting crime."
        hero12.image = "Punisher"
        
        let hero13: ArrayInfo = ArrayInfo()
        hero13.title = "Namor"
        hero13.subtitle = "Namor McKenzie"
        hero13.detail = "Namor debuted in the Golden Age of Comics and was the original anti-hero of comics. Interestingly, Namor was the first super-hero who was able to fly. His meeting and subsequent battle with the original Human Torch (the android called Jim Hammond) in Marvel Mystery Comics #8 (June 1940), made comic history as it was the first superhero meeting and team-up in comics history and it established for the first time the concept of a shared fictional universe inhabited by many various superheroes in comics."
        hero13.image = "Namor"
        
        let hero14: ArrayInfo = ArrayInfo()
        hero14.title = "Storm"
        hero14.subtitle = "Ororo Munroe"
        hero14.detail = "Of the many mutants in the world, Ororo Munroe is one of the most powerful. Born with the ability to control the weather, Storm is a longtime defender of Xavier's dream. While her vast power set makes her formidable in battle, it's her role as a teacher that's most impactful --  she's gone from student to Headmistress in her expansive tenure. She was once chased as a thief, worshiped as a goddess, and bowed to as a queen, but today she's most known for inspiring the next generation of mutants to be the best they can be."
        hero14.image = "Storm"
        
        let hero15: ArrayInfo = ArrayInfo()
        hero15.title = "Vision"
        hero15.subtitle = "Victor Shade"
        hero15.detail = "The Vision is able to fly and possesses complete control over his density, enabling him to render himself intangible or extraordinarily massive and diamond-hard at will. He can partially materialize within another person, causing his victim extreme pain. The solar cell on the Vision's forehead emits beams of infrared and microwave radiation, with temperatures ranging from 500 to 30,000 degrees Fahrenheit."
        hero15.image = "Vision"
        
        let hero16: ArrayInfo = ArrayInfo()
        hero16.title = "Mr. Fantastic"
        hero16.subtitle = "Reed Richards"
        hero16.detail = "The character is a founding member of the Fantastic Four. Richards possesses a mastery of mechanical, aerospace and electrical engineering, chemistry, all levels of physics, and human and alien biology. He is the inventor of the spacecraft that was bombarded by cosmic radiation on its maiden voyage, granting the Fantastic Four their powers. Richards gained the ability to stretch his body into any shape he desires."
        hero16.image = "Mr_Fantastic"
        
        let hero17: ArrayInfo = ArrayInfo()
        hero17.title = "Thing"
        hero17.subtitle = "Ben Grimm"
        hero17.detail = "Sweet Aunt Petunia's favorite little nephew, Ben Grimm's road to heroism got off to a rocky start. The sole member of the Fantastic Four to get a not-so-fantastic makeover along with his powers,Thing was initially burdened by his outwardly craggy appearance. He's since learned to appreciate his new form, developing into a hero as powerful as he is funny and sincere. The character fosters a big heart and a strong sense of family, but when that gets threatened, you can always count on it being clobberin' time."
        hero17.image = "Thing"
        
        let hero18: ArrayInfo = ArrayInfo()
        hero18.title = "Invisible Woman"
        hero18.subtitle = "Susan \"Sue\" Storm Richards"
        hero18.detail = "Doctor Doom himself said that the Invisible Woman is the most powerful member of the Fantastic Four, and he was right in more than one way. We’ve yet to see the limits of her force field powers, but beyond her abilities, she’s the heart, soul, and mom of the group. She has long been the voice of reason of the team, curbing the more drastic approaches of her teammates and stepping in with a well-timed force field when things get out of hand."
        hero18.image = "Invisible"
        
        let hero19: ArrayInfo = ArrayInfo()
        hero19.title = "Beast"
        hero19.subtitle = "Hank McCoy"
        hero19.detail = "Born with a mutation that left his strength and reflexes heightened and his limbs enlarged, Hank McCoy was one of the five founding members of the X-Men. Possessing genius level intelligence and incredible physical ability, Beast still struggled with his outward appearance, eventually taking a self-made serum in the hopes of reversing its effects. The serum instead triggered a secondary mutation, turning him into a furry blue cat-man. Despite these setbacks, the former Avenger remains a vital member of the X-Man, overcoming his trials by using his incredible intellect and, when that doesn't work, his razor sharp claws."
        hero19.image = "Beast"
        
        let hero20: ArrayInfo = ArrayInfo()
        hero20.title = "Human Torch"
        hero20.subtitle = "Jonathan Lowell Spencer Storm"
        hero20.detail = "Like the rest of the Fantastic Four, Jonathan \"Johnny\" Storm gained his powers on a spacecraft bombarded by cosmic rays. He can engulf his entire body in flames, can fly, can absorb fire harmlessly into his own body, and can control any nearby fire by sheer force of will. \"Flame on!\" which the Torch customarily shouts when activating his full-body flame effect, has become his catchphrase."
        hero20.image = "Human_Torch"
        
        // Pass in the heroes into the storyboard
        dataArray = [hero1, hero2, hero3, hero4, hero5, hero6, hero7, hero8, hero9, hero10, hero11, hero12, hero13, hero14, hero15, hero16, hero17, hero18, hero19, hero20
        ]
        
        // For in loop to iterate through array
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
        
        if let cell: MarvelViewCell = tableView.dequeueReusableCell(withIdentifier: heroCell)! as? MarvelViewCell {
        
        let currentHero: ArrayInfo = dataArray[indexPath.row]
        
        // Uses the local variable array as its return
        cell.heroLabel!.text = currentHero.title
        cell.subLabel!.text = currentHero.subtitle
        cell.heroImage!.image = UIImage(named: currentHero.image)
        
        return cell
            
        } else {
            
            return MarvelViewCell()
            
        }
    }
    
        // Allows to edit row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            
            // This will delete the item from the dataArray
            dataArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // Function connects segue from View Controller to Detail View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailView: DetailViewController = segue.destination as! DetailViewController
        
        let indexPath: IndexPath? = tableView.indexPathForSelectedRow
        
        let currentHero: ArrayInfo = dataArray[indexPath!.row]
        
        detailView.currentHero = currentHero
        
    }
    
    // Toggle edit button for row deletion
    @IBAction func myToggle(_ sender: UIButton) {
        
        tableView.isEditing = !tableView.isEditing
        
    }
    
    
}
