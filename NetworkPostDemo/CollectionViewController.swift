//
//  CollectionViewController.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/8/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

private let newsCellId = "NewsFeedCell"
private let postCellId = "PostFeedCell"
private let lykImageUrl = "http://52.90.18.119/lykjwt/uploads/lyk.png"
private let postBaseUrl = "https://www.lykapp.com/lykjwt/uploads/images/"
class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var data = [Any]()
    
    //TODO: UPDATE WITH TABLEVIEW CONFIGURATION 
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10;
        collectionView?.setCollectionViewLayout(flowLayout, animated: true)
        self.collectionView!.register(PostFeedCollectionViewCell.self, forCellWithReuseIdentifier: postCellId)
        self.collectionView!.register(NewsFeedCollectionViewCell.self, forCellWithReuseIdentifier: newsCellId)
        retrieveData()
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let approxWidthOfTitle = view.frame.width //- 4
        let size = CGSize(width: approxWidthOfTitle, height: 1000)
        let titleAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        let newDescriptionAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let item = data[indexPath.row]
        switch item {
            case let item as RawPostDetails:
                let estimatedTitleFrame = NSString(string: item.title)
                    .boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: titleAttributes, context: nil)
                
                if item.imageUrl != nil{
                    // - - -imageview itself -padding for text
                    return CGSize(width: view.bounds.width, height: estimatedTitleFrame.height + 150 + 12 + 700 + 24)
                }
                return CGSize(width: view.bounds.width, height: estimatedTitleFrame.height + 150 + 12)
            case let item as RawNewsDetails:
                let estimatedTitleFrame = NSString(string: item.newsTitle)
                    .boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: titleAttributes, context: nil)
                let estimatedDescriptionFrameHeight = NSString(string: item.newsTitle)
                    .boundingRect(with: size, options: .usesLineFragmentOrigin,
                                  attributes: newDescriptionAttributes, context: nil)
                    .height + 12 //text container insets
                return CGSize(width: view.bounds.width,
                              height: estimatedTitleFrame.height + estimatedDescriptionFrameHeight + 475 + 12)
            default:
                return CGSize(width: view.bounds.width, height: 0)
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = data[indexPath.row]
        let postCell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: postCellId, for: indexPath) as! PostFeedCollectionViewCell
        let newsCell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: newsCellId, for: indexPath) as! NewsFeedCollectionViewCell
        switch item {
        case let feedItem as RawPostDetails:
            postCell.header.informationView.text = feedItem.createdBy.firstName
            if let profileImageUrl = feedItem.createdBy.imageUrl{
                postCell.header.profileImageView.loadAsyncFrom(url: profileImageUrl, placeholder: nil)
            }else{
                postCell.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            }
            postCell.header.informationView.text?.append("\n\(Utility.lykTime(from: feedItem.feedTime).timeAgoSince())")
            
            if feedItem.title == "" {
                postCell.body.removeTitle()
            }else{
                postCell.body.titleView.text = feedItem.title
            }
            
            if let feedItemImageUrl = feedItem.imageUrl{
                postCell.body.urlString = "\(postBaseUrl)\(feedItemImageUrl)"
            }
            postCell.backgroundColor = UIColor.white
            postCell.footer.likeTextView.text = "\(feedItem.likeCount) Likes"
            postCell.footer.commentTextView.text = "\(feedItem.commentCount) Comments"
            postCell.footer.shareTextView.text = "\(feedItem.shareCount) Shares"
            return postCell
        case let feedItem as RawNewsDetails:
            newsCell.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            newsCell.header.informationView.text = "LYK"
            newsCell.header.informationView.text?.append("\n\(Utility.lykTime(from: feedItem.feedTime).timeAgoSince())")
            newsCell.body.titleView.text = feedItem.newsTitle
            newsCell.body.urlString = feedItem.newsImageUrl.removingWhitespaces()
            newsCell.body.newsDescriptionView.text = feedItem.newsDescription
            newsCell.body.sourceTextView.text = "Source: \(feedItem.newsSource)"
            newsCell.body.poweredByView.text = feedItem.poweredBy
            newsCell.backgroundColor = UIColor.white
            newsCell.footer.likeTextView.text = "\(feedItem.likeCount) Likes"
            newsCell.footer.commentTextView.text = "\(feedItem.commentCount) Comments"
            newsCell.footer.shareTextView.text = "\(feedItem.shareCount) Shares"
            return newsCell
        default:
            print("UNSUPPORTED")
        }
        return UICollectionViewCell()
    }

    
    func retrieveData(){
        LykAppService.shared.retrieveAll(completion: { (items) in
            if let items = items{
                self.data = items
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        })
    }

}
