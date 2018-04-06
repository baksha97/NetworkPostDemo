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
        LykAppService.shared.retrievePostAndNews(completion: { (posts, news) in
            print(posts?.count)
            print(news?.count)
        })
        
    }
    
}


