//
//  ViewController.swift
//  boynton_allen_project2
//
//  Created by Allen Boynton on 10/30/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//  Converted to Swift 3.0

import UIKit

// Local variables
var dataArray: [ArrayInfo] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlet to connect my table view
    @IBOutlet weak var fireTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Article objects
        let article1: ArrayInfo = ArrayInfo()
            article1.title = "\"Fire-Modified Meteorology in a Coupled Fire–Atmosphere Model\""
            article1.source = "Ebsco"
            article1.image = "article1"
            article1.article = "The coupled fire–atmosphere model consisting of the Weather and Forecasting (WRF) Model coupled with the fire-spread model (SFIRE) module has been used to simulate a bushfire at D’Estrees Bay on Kangaroo Island, South Australia, in December 2007."
            article1.link = "http://web.a.ebscohost.com.oclc.fullsail.edu:81/ehost/pdfviewer/pdfviewer?vid=10&sid=6519dce7-8437-4eaf-a2be-39e9406edd7e%40sessionmgr4002&hid=4109"
            article1.references = "Peace, M., Mattner, T., Mills, G., Kepert, J., & McCaw, L. (2015). Fire-Modified Meteorology in a Coupled Fire-Atmosphere Model. Journal Of Applied Meteorology & Climatology, 54(3), 704-720. doi:10.1175/JAMC-D-14-0063.1"
        
        let article2: ArrayInfo = ArrayInfo()
            article2.title = "\"Darlington County school bus catches fire with students onboard\""
            article2.source = "ABC News"
            article2.image = "article2"
            article2.article = "A Darlington County School bus caught fire Wednesday afternoon with 15 students from Darlington High School and Darlington Middle School on board, according to district administrators."
            article2.link = "http://wpde.com/news/local/darlington-county-school-bus-catches-fire-with-students-onboard"
            article2.references = "Brown, T. (2015, November 4). Darlington County school bus catches fire with students onboard. Retrieved November 11, 2015, from http://wpde.com/news/local/darlington-county-school-bus-catches-fire-with-students-onboard"
        
        let article3: ArrayInfo = ArrayInfo()
            article3.title = "\"Aiken County Commercial Building Fire\""
            article3.source = "WJBF.com"
            article3.image = "article3"
            article3.article = "We have an update now to a story we brought you Tuesday morning on Good Morning Augusta after a fire broke out at a North Augusta business. The owner of B&E Heating and Air tells us, even though the building for his business is damaged, his business is still fully operational."
            article3.link = "http://wjbf.com/2015/11/03/crews-battling-structure-fire-in-north-augusta/"
            article3.references = "Bloodsworth, E. (2015, November 3). Despite Fire, North Augusta Business Owner Says His Business Is Still Open. Retrieved November 11, 2015, from http://wjbf.com/2015/11/03/crews-battling-structure-fire-in-north-augusta/"
        
        let article4: ArrayInfo = ArrayInfo()
            article4.title = "\"House Fire in Greer Kills Family Pet\""
            article4.source = "FOX Carolina"
            article4.image = "article4"
            article4.article = "The fire was out as of 7:30 p.m. on Tuesday. No one was injured but a pet cat was killed in the fire."
            article4.link = "http://www.foxcarolina.com/story/30367731/fire-damages-greer-home#ixzz3pofeZOtv"
            article4.references = "Carpenter, H. (2015, October 28). Fire damages Greer home, family loses pet. Retrieved November 11, 2015, from http://www.foxcarolina.com/story/30367731/fire-damages-greer-home#ixzz3pofeZOtv"
        
        let article5: ArrayInfo = ArrayInfo()
            article5.title = "\"Police Arrest Man In Connection With Recent St.Louis Church Fire?'"
            article5.source = "NPR.com"
            article5.image = "article5"
            article5.article = "A 35-year-old man was arrested and charged in connection with a pair of recent church fires in and around St. Louis."
            article5.link = "http://www.npr.org/sections/thetwo-way/2015/10/30/453236905/police-arrest-man-in-connection-with-recent-st-louis-church-fires"
            article5.references = "Ruiz, J. (2015, October 30). Police Arrest Man In Connection With Recent St. Louis Church Fires. Retrieved November 11, 2015, from http://www.npr.org/sections/thetwo-way/2015/10/30/453236905/police-arrest-man-in-connection-with-recent-st-louis-church-fires"

        
        // Pass in the article info into the storyboard
        dataArray.append(article1)
        dataArray.append(article2)
        dataArray.append(article3)
        dataArray.append(article4)
        dataArray.append(article5)
        
    }

    // Add labels to the table view section
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ObjectViewCell = tableView.dequeueReusableCell (withIdentifier: "MyCell") as! ObjectViewCell!
        
        let firePin: ArrayInfo = dataArray[indexPath.row]
        
        // Uses the local variable array as its return
        cell.fireArticle!.text = firePin.title
        cell.fireSource!.text = firePin.source
        cell.fireImage.image = UIImage(named: firePin.image)
        
        return cell
    }

    // Add # of rows to table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // Function connects segue from View Controller to Detail View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: DetailViewController = segue.destination as! DetailViewController
        let indexPath: IndexPath? = fireTableView.indexPathForSelectedRow!
        let currentFire: ArrayInfo = dataArray[indexPath!.row]
        detailView.currentFire = currentFire
    }
    
    // Created back button to return to the main menu
    @IBAction func backButton(_ segue: UIStoryboardSegue) {
        
    }

}

