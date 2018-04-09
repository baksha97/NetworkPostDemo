//
//  ViewController.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

private let newsCellId = "NewsFeedCell"
private let postCellId = "PostFeedCell"
private let lykImageUrl = "http://52.90.18.119/lykjwt/uploads/lyk.png"
private let postBaseUrl = "https://www.lykapp.com/lykjwt/uploads/images/"
class TableViewController: UITableViewController {
    
    var data = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(PostFeedTableViewCell.self, forCellReuseIdentifier: "PostFeedCell")
        self.tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "NewsFeedCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 450.0
        self.tableView.insetsContentViewsToSafeArea = true
        retrieveData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let newsCell = self.tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell") as! NewsFeedTableViewCell
        let postCell = self.tableView.dequeueReusableCell(withIdentifier: "PostFeedCell") as! PostFeedTableViewCell
        
        switch item {
        case let feedItem as PostDetails:
            PostObjectManager.shared.postCell(from: feedItem, in: postCell)
            return postCell
        case let feedItem as NewsDetails:
            PostObjectManager.shared.newsCell(from: feedItem, in: newsCell)
            return newsCell
        default:
            print("UNSUPPORTED")
        }
        
        return UITableViewCell()
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func retrieveData(){
        LykAppService.shared.retrieveAll(completion: { (items) in
            if let items = items{
                self.data = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.layoutIfNeeded()
                }
            }
        })
    }
}
