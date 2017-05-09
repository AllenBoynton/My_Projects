//
//  ViewController.swift
//  boynton_allen_project4
//
//  Created by Allen Boynton on 11/16/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    var webView: SourceText? = SourceText()
    
    var urlRequest: URLRequest? = nil
    
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Request of the URL
        urlRequest = URLRequest(url: webView!.webPage! as URL)
        
        // Setting up the size and load the loading of the URL
        myWebView.scalesPageToFit = true
        
        myWebView.loadRequest(urlRequest!)
        
    }
    
    // Allows the back or forward button to gray out if there is nowhere to go
    override func viewWillAppear(_ animated: Bool) {
        
        backButton.isEnabled = myWebView.canGoBack
        nextButton.isEnabled = myWebView.canGoForward
        
    }
    
    // Create back button for web view
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        
        if (myWebView.canGoBack) {
            
            myWebView.goBack()
            
        }
        
    }
    
    // Create next button for web view
    @IBAction func goForward(_ sender: AnyObject) {
        
        if (myWebView.canGoForward) {
            
            myWebView.goForward()
            
        }
        
    }
    
    // Refresh web view
    @IBAction func reload(_ sender: AnyObject) {
        
        myWebView.reload()
        
    }
    
    @IBAction func tapGo(_ sender: AnyObject) {
        
        if addressBar.text == "" {
            
            return
            
        }
        
        guard let text: String = addressBar.text else {
            
            return
            
        }
        
        if text.range(of: ".") != nil {
            
            var finalString: String = text.lowercased()
            
            if finalString.range(of: "https://") == nil {
                
                finalString = "https://\(finalString)"
                
            }
            
            self.loadURL(finalString)
            
        }
    }
    
    func loadURL(_ str: String) {
    
        let url = URL(string: str)
    
        let request = URLRequest(url: url!)
    
        myWebView.loadRequest(request)
        
    }
    
    // Create action for stop button on web view
    @IBAction func stop(_ sender: UIBarButtonItem) {
        
        if (myWebView.isLoading) {
            
            myWebView.stopLoading()
            
        }
        
    }
    
    
    // Verifies that web page finished loading
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        backButton.isEnabled = myWebView.canGoBack
        nextButton.isEnabled = myWebView.canGoForward
        
    }

}

