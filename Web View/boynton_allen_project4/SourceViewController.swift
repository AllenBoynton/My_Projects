//
//  SourceViewController.swift
//  boynton_allen_project4
//
//  Created by Allen Boynton on 11/16/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit

class SourceViewController: UIViewController, NSURLConnectionDataDelegate {
    
    let urlString: URL? = URL(string: "https://kairoswatches.com/")
    var connection: URLSession? = nil
    var request: URLRequest? = nil
    let requestData: NSMutableData = NSMutableData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request = URLRequest(url: urlString!)
        
        connection = URLSession(configuration: request!, delegate: self, delegateQueue: true)
        
    }
    
    @IBOutlet weak var myWebSource: UITextView!

    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        
        requestData.append(data)
        
    }
    
    // Function is called when the connection is complete and all data is received
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        
        let htmlView = String(data: requestData as Data, encoding: String.Encoding.ascii)!
        myWebSource.text = htmlView
    }
    
}
