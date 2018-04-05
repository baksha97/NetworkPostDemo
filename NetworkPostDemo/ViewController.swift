//
//  ViewController.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.lykapp.com/lykjwt/index.php?/relatedData/getHomeFeed")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //Param: {"userId":"3196",  "offset": 0, "limit":25 }
        let postString = "userId=3196&offset=0&limit=25"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(httpStatus)")
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            
//            let json = try! JSONSerialization.jsonObject(with: data, options: [])
//
            let json = try! JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as! [String:Any]
            
            //print(json["response"]!["feeds"])
            
            let response = json["response"] as! [String: Any]
            let feeds = response["feeds"]as! NSArray

            
            for item in feeds{
                let post = item as! [String: Any]
                print(post["type"])
            }
            
        }
        task.resume()  
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

