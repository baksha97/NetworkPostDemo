//
//  PostManager.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/9/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

//This will be used to keep our Views seperate and cleaner than doubling back and forth
//May not be of use once a specific Controller is decided upon.
class PostObjectManager{
    private init(){}
    static let shared = PostObjectManager()
    
    //MARK: Identifiers
    let newsCellId = "NewsFeedCell"
    let postCellId = "PostFeedCell"
    //MARK: Static URLS
    let lykImageUrl = "https://cdn.lykapp.com/assets/images/logo.png"
    let postBaseUrl = "https://www.lykapp.com/lykjwt/uploads/images/"
    
    //modifies post cell as either a collectionview or a tableview
    //i have attempted to create ONE PostView and configure that - then apply to both cells, but it will not work as intended... I have blank cells.
    func postCell(from postDetail: PostDetails, in postCell: Any){
        switch postCell {
        case let postCell as PostFeedTableViewCell:
            postCell.view.header.headerInformationView.text = postDetail.createdBy.firstName
            if let profileImageUrl = postDetail.createdBy.imageUrl{
                postCell.view.header.profileImageView.loadAsyncFrom(url: profileImageUrl, placeholder: nil)
            }else{
                postCell.view.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            }
            postCell.view.header.headerInformationView.text?.append("\n\(LykAppService.lykTime(from: postDetail.feedTime).timeAgoSince())")
            
            if postDetail.title == "" {
                // currently in the Lyk URL data pull, the "SHARED" post types are recieved as post and is not automatically differientiated with
                // the response of { type = ___ [currently set as post] }
                 postCell.view.body.removeTitle()
            }else{
                postCell.view.body.titleView.text = postDetail.title
            }
            
            if let feedItemImageUrl = postDetail.imageUrl{
                postCell.view.body.urlString = "\(postBaseUrl)\(feedItemImageUrl)"
            }else{
                postCell.view.body.removeImageView()
            }
            postCell.backgroundColor = UIColor.white
            postCell.view.footer.likeTextView.text = "\(postDetail.likeCount) Likes"
            postCell.view.footer.commentTextView.text = "\(postDetail.commentCount) Comments"
            postCell.view.footer.shareTextView.text = "\(postDetail.shareCount) Shares"
            
        case let postCell as PostFeedCollectionViewCell:
            postCell.view.header.headerInformationView.text = postDetail.createdBy.firstName
            if let profileImageUrl = postDetail.createdBy.imageUrl{
                postCell.view.header.profileImageView.loadAsyncFrom(url: profileImageUrl, placeholder: nil)
            }else{
                postCell.view.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            }
            postCell.view.header.headerInformationView.text?.append("\n\(LykAppService.lykTime(from: postDetail.feedTime).timeAgoSince())")
        
            if postDetail.title == "" {
                // currently in the Lyk URL data pull, the "SHARED" post types are recieved as post and is not automatically differientiated with
                // the response of { type = ___ [currently set as post] }
                postCell.view.body.removeTitle()
            }else{
                postCell.view.body.titleView.text = postDetail.title
            }
            
            if let feedItemImageUrl = postDetail.imageUrl{
                postCell.view.body.urlString = "\(postBaseUrl)\(feedItemImageUrl)"
            }else{
                postCell.view.body.removeImageView()
            }
            
            postCell.backgroundColor = UIColor.white
            postCell.view.footer.likeTextView.text = "\(postDetail.likeCount) Likes"
            postCell.view.footer.commentTextView.text = "\(postDetail.commentCount) Comments"
            postCell.view.footer.shareTextView.text = "\(postDetail.shareCount) Shares"
        default:
            print("Cell type unsupported")
        }
    }
    
    //modifies news cell as either a collectionview or a tableview
    func newsCell(from newsDetail: NewsDetails, in newsCell: Any){
        
        switch newsCell {
        case let newsCell as NewsFeedTableViewCell:
            newsCell.view.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            newsCell.view.header.headerInformationView.text = "LYK"
            newsCell.view.header.headerInformationView.text?.append("\n\(LykAppService.lykTime(from: newsDetail.feedTime).timeAgoSince())")
            newsCell.view.body.titleView.text = newsDetail.newsTitle
            newsCell.view.body.urlString = newsDetail.newsImageUrl.replaceUrlSpaces()
            newsCell.view.body.newsDescriptionView.text = newsDetail.newsDescription
            newsCell.view.body.sourceTextView.text = "Source: \(newsDetail.newsSource)"
            newsCell.view.body.poweredByView.text = newsDetail.poweredBy
            newsCell.backgroundColor = UIColor.white
            newsCell.view.footer.likeTextView.text = "\(newsDetail.likeCount) Likes"
            newsCell.view.footer.commentTextView.text = "\(newsDetail.commentCount) Comments"
            newsCell.view.footer.shareTextView.text = "\(newsDetail.shareCount) Shares"
        case let newsCell as NewsFeedCollectionViewCell:
            newsCell.view.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            newsCell.view.header.headerInformationView.text = "LYK"
            newsCell.view.header.headerInformationView.text?.append("\n\(LykAppService.lykTime(from: newsDetail.feedTime).timeAgoSince())")
            newsCell.view.body.titleView.text = newsDetail.newsTitle
            newsCell.view.body.urlString = newsDetail.newsImageUrl.replaceUrlSpaces()
            newsCell.view.body.newsDescriptionView.text = newsDetail.newsDescription
            newsCell.view.body.sourceTextView.text = "Source: \(newsDetail.newsSource)"
            newsCell.view.body.poweredByView.text = newsDetail.poweredBy
            newsCell.view.backgroundColor = UIColor.white
            newsCell.view.footer.likeTextView.text = "\(newsDetail.likeCount) Likes"
            newsCell.view.footer.commentTextView.text = "\(newsDetail.commentCount) Comments"
            newsCell.view.footer.shareTextView.text = "\(newsDetail.shareCount) Shares"
        default:
            print("Cell type unsupported")
        }
    }
    
}
