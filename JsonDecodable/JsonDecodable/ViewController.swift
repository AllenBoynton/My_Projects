//
//  ViewController.swift
//  JsonDecodable
//
//  Created by Allen Boynton on 7/4/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//
//  Json parsing with minimal code
import UIKit

//  A protocol type that can decode itself from an external representation...Decodable
struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
 
    init(json: [String : Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        link = json["link"] as? String ?? ""
        imageUrl = json["imageUrl"] as? String ?? ""
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Json example online
        let jsonUrlString = "http://api.letsbuildthatapp.com/jsondecodable/courses"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            // check err
            // also check response status 200
            guard let data = data else { return }
            
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)
            
            //Swift 4
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                print(courses)
                
                
                //Swift 2/3/ObjC
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return
//                }
//                
//                let course = Course.init(json: json)
//                print(course.name)
                
            } catch let jsonErr {
                print("Error socializing json: ", jsonErr)
            }
        }.resume()
    }
}

