//
//  VideoViewController.swift
//  boynton_allen_project2
//
//  Created by Allen Boynton on 11/1/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UIWebViewDelegate {
    
    var wildFire: URL? = URL(string: "https://www.youtube.com/watch?v=CSB9pTurhi4")
    
    var urlRequest: URLRequest? = nil
    
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlRequest = URLRequest(url: wildFire!)
        
        myWebView.scalesPageToFit = true
        myWebView.loadRequest(urlRequest!)
        
    }
    
    // Create back to view controller button
    override func viewWillAppear(_ animated: Bool) {
        
        backButton.isEnabled = myWebView.canGoBack
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Create back button for web view
    @IBAction func back(_ sender: UIBarButtonItem) {
        
        if (myWebView.canGoBack) {
            
            myWebView.goBack()
            
        }
        
    }
    
    // Create forward button for web view
    @IBAction func forward(_ sender: AnyObject) {
        
        myWebView.goForward()
        
    }
    
    // Create action for stop button on web view
    @IBAction func stop(_ sender: UIBarButtonItem) {
        
        if (myWebView.isLoading) {
            
            myWebView.stopLoading()
            
        }
        
    }
    
    // Refresh web view
    @IBAction func refresh(_ sender: AnyObject) {
        
        myWebView.reload()
        
    }
    
    // Button is enabled to let you know it is able to be used
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        backButton.isEnabled = myWebView.canGoBack
        
    }
    
    // Created back button to return to the main menu
    @IBAction func backButton3(_ segue: UIStoryboardSegue) {
        
    }
    
}
