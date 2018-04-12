//
//  ViewController.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //set of items
    var data = [Any]()
    
    //gets data as soon as possible
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(PostFeedTableViewCell.self, forCellReuseIdentifier: PostObjectManager.shared.postCellId)
        self.tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: PostObjectManager.shared.newsCellId)
        self.tableView.rowHeight = UITableViewAutomaticDimension //allows cell to resize according || the imageviews do not autmatically resize - need to place .layoutSubviews() in an appropriate place to provide this when an image is loaded.
        self.tableView.estimatedRowHeight = 450.0
        self.tableView.insetsContentViewsToSafeArea = true
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let postCell = self.tableView.dequeueReusableCell(withIdentifier: PostObjectManager.shared.postCellId) as! PostFeedTableViewCell
        let newsCell = self.tableView.dequeueReusableCell(withIdentifier: PostObjectManager.shared.newsCellId) as! NewsFeedTableViewCell

        
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
                self.data = items.reversed()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.setNeedsLayout()
                    self.tableView.layoutIfNeeded()
                }
            }
        })
    }
}
