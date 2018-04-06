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
//
        LykAppService.shared.retrieveAll(completion: { (items) in
            if let items = items{
                for item in items{
                    switch item {
                    case let feedItem as RawPostDetails:
                        print(feedItem.title)
                    case _ as RawNewsDetails:
                        print()
                    default:
                        print("not string")
                    }
                }
            }
        })
        
    }
    
}


