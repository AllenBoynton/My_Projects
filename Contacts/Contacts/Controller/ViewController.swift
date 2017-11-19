//
//  ViewController.swift
//  Contacts
//
//  Created by Allen Boynton on 11/18/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellId = "cellId"
    
    let names = Names()
    
    var showIndexPaths = false
    
    @objc func handleShowIndexPath() {
        print("Attempting reload animation of indexPaths...")
        
        // Build all the indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()
        
        // Perform a double loop to iterate through all sections and rows
        for section in names.namesArray.indices {
            for row in names.namesArray[section].indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        
        // Alternate animation from left to right
        showIndexPaths = !showIndexPaths
        
        // Creating the animation pattern
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = .orange
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return names.namesArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.namesArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = names.namesArray[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = name
        
        if showIndexPaths {
        cell.textLabel?.text = "\(name) Section: \(indexPath.section) Row: \(indexPath.row)"
        }
        
        return cell
    }
}

