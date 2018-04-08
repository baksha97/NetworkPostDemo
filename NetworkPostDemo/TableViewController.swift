//
//  ViewController.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var data = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(PostFeedCell.self, forCellReuseIdentifier: "PostFeedCell")
        self.tableView.register(NewsFeedCell.self, forCellReuseIdentifier: "NewsFeedCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 450.0
        self.tableView.insetsContentViewsToSafeArea = true
        retrieveData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let newsCell = self.tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell") as! NewsFeedCell
        let postCell = self.tableView.dequeueReusableCell(withIdentifier: "PostFeedCell") as! PostFeedCell
        switch item {
            case let feedItem as RawPostDetails:
                postCell.header.nameLabel.text = feedItem.createdBy.firstName
                if let profileImageUrl = feedItem.createdBy.imageUrl{
                    postCell.header.profileImageView.loadAsyncFrom(url: profileImageUrl, placeholder: nil)
                }else{
                    postCell.header.profileImageView.loadAsyncFrom(url: "https://d1qb2nb5cznatu.cloudfront.net/startups/i/687472-5368eb389a35c22b4ca3ee91773d2a6f-medium_jpg.jpg?buster=1505195278", placeholder: nil)
                }
                postCell.header.timeTextView.text = Utility.lykTime(from: feedItem.feedTime).timeAgoSince()
                
                postCell.body.titleView.text = feedItem.title
                if let feedItemImageUrl = feedItem.imageUrl{
                   // postCell.body.mainImageView.loadAsyncFrom(url: feedItemImageUrl, placeholder: nil)
                    print("post image currently unsupported for \(feedItemImageUrl)")
                }
                postCell.footer.likeTextView.text = "\(feedItem.likeCount) Likes"
                postCell.footer.commentTextView.text = "\(feedItem.commentCount) Comments"
                postCell.footer.shareTextView.text = "\(feedItem.shareCount) Shares"
                return postCell
            case let feedItem as RawNewsDetails:
                newsCell.header.profileImageView.loadAsyncFrom(url: "https://d1qb2nb5cznatu.cloudfront.net/startups/i/687472-5368eb389a35c22b4ca3ee91773d2a6f-medium_jpg.jpg?buster=1505195278", placeholder: nil)
                newsCell.header.nameLabel.text = "LYK"
                newsCell.header.timeTextView.text = Utility.lykTime(from: feedItem.feedTime).timeAgoSince()//feedItem.feedTime
                newsCell.body.titleView.text = feedItem.newsTitle
                newsCell.body.mainImageView.loadAsyncFrom(url: feedItem.newsImageUrl, placeholder: #imageLiteral(resourceName: "placeholder"))
                newsCell.body.newsDescriptionView.text = feedItem.newsDescription
                newsCell.body.poweredByView.text = feedItem.poweredBy
                newsCell.footer.likeTextView.text = "\(feedItem.likeCount) Likes"
                newsCell.footer.commentTextView.text = "\(feedItem.commentCount) Comments"
                newsCell.footer.shareTextView.text = "\(feedItem.shareCount) Shares"
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
                }
            }
        })
    }
}
