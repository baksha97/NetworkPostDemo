//
//  ViewController.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//


import UIKit
import SDWebImage

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
        let postCell = self.tableView.dequeueReusableCell(withIdentifier: postCellId) as! PostFeedTableViewCell
        let newsCell = self.tableView.dequeueReusableCell(withIdentifier: newsCellId) as! NewsFeedTableViewCell
        switch item {
        case let feedItem as RawPostDetails:
            postCell.postView.header.informationView.text = feedItem.createdBy.firstName
            if let profileImageUrl = feedItem.createdBy.imageUrl{
                postCell.postView.header.profileImageView.loadAsyncFrom(url: profileImageUrl, placeholder: nil)
            }else{
                postCell.postView.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            }
            postCell.postView.header.informationView.text?.append("\n\(Utility.lykTime(from: feedItem.feedTime).timeAgoSince())")
            
            if feedItem.title == "" {
                postCell.postView.body.removeTitle()
            }else{
                postCell.postView.body.titleView.text = feedItem.title
            }
            
            if let feedItemImageUrl = feedItem.imageUrl{
                //postCell.postView.body.urlString = "\(postBaseUrl)\(feedItemImageUrl)"
               postCell.postView.body.mainImageView.sd_setImage(with: URL(string: feedItemImageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            }else{
                postCell.postView.body.removeImageView()
            }
            postCell.backgroundColor = UIColor.white
            postCell.postView.footer.likeTextView.text = "\(feedItem.likeCount) Likes"
            postCell.postView.footer.commentTextView.text = "\(feedItem.commentCount) Comments"
            postCell.postView.footer.shareTextView.text = "\(feedItem.shareCount) Shares"
            return postCell
        case let feedItem as RawNewsDetails:
            newsCell.newsView.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            newsCell.newsView.header.informationView.text = "LYK"
            newsCell.newsView.header.informationView.text?.append("\n\(Utility.lykTime(from: feedItem.feedTime).timeAgoSince())")
            newsCell.newsView.body.titleView.text = feedItem.newsTitle
            newsCell.newsView.body.urlString = feedItem.newsImageUrl.removingWhitespaces()
            newsCell.newsView.body.newsDescriptionView.text = feedItem.newsDescription
            newsCell.newsView.body.sourceTextView.text = "Source: \(feedItem.newsSource)"
            newsCell.newsView.body.poweredByView.text = feedItem.poweredBy
            newsCell.backgroundColor = UIColor.white
            newsCell.newsView.footer.likeTextView.text = "\(feedItem.likeCount) Likes"
            newsCell.newsView.footer.commentTextView.text = "\(feedItem.commentCount) Comments"
            newsCell.newsView.footer.shareTextView.text = "\(feedItem.shareCount) Shares"
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

