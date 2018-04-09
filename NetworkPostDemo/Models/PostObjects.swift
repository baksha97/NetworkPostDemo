//
//  PostObjects.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

private let newsCellId = "NewsFeedCell"
private let postCellId = "PostFeedCell"
private let lykImageUrl = "http://52.90.18.119/lykjwt/uploads/lyk.png"
private let postBaseUrl = "https://www.lykapp.com/lykjwt/uploads/images/"

import UIKit

enum LykItemType: String{
    case news
    case posts
}

class PostObjectManager{
    private init(){}
    static let shared = PostObjectManager()
    
    func postCell(from postDetail: PostDetails, in postCell: Any){
        switch postCell {
        case let postCell as PostFeedTableViewCell:
            postCell.header.informationView.text = postDetail.createdBy.firstName
            if let profileImageUrl = postDetail.createdBy.imageUrl{
                postCell.header.profileImageView.loadAsyncFrom(url: profileImageUrl, placeholder: nil)
            }else{
                postCell.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            }
            postCell.header.informationView.text?.append("\n\(Utility.lykTime(from: postDetail.feedTime).timeAgoSince())")
            
            if postDetail.title == "" {
                // currently removing hyperlinks 0 for unkown reasons
                // postCell.body.removeTitle()
            }else{
                postCell.body.titleView.text = postDetail.title
            }
            
            if let feedItemImageUrl = postDetail.imageUrl{
                postCell.body.urlString = "\(postBaseUrl)\(feedItemImageUrl)"
            }else{
                postCell.body.removeImageView()
            }
            postCell.backgroundColor = UIColor.white
            postCell.footer.likeTextView.text = "\(postDetail.likeCount) Likes"
            postCell.footer.commentTextView.text = "\(postDetail.commentCount) Comments"
            postCell.footer.shareTextView.text = "\(postDetail.shareCount) Shares"
            
         case let postCell as PostFeedCollectionViewCell:
            postCell.header.informationView.text = postDetail.createdBy.firstName
            if let profileImageUrl = postDetail.createdBy.imageUrl{
                postCell.header.profileImageView.loadAsyncFrom(url: profileImageUrl, placeholder: nil)
            }else{
                postCell.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            }
            postCell.header.informationView.text?.append("\n\(Utility.lykTime(from: postDetail.feedTime).timeAgoSince())")
            
            if postDetail.title == "" {
                // currently removing hyperlinks - for unkown reasons
                // postCell.body.removeTitle()
            }else{
                postCell.body.titleView.text = postDetail.title
            }
            
            if let feedItemImageUrl = postDetail.imageUrl{
                postCell.body.urlString = "\(postBaseUrl)\(feedItemImageUrl)"
            }else{
                postCell.body.removeImageView()
            }
            postCell.backgroundColor = UIColor.white
            postCell.footer.likeTextView.text = "\(postDetail.likeCount) Likes"
            postCell.footer.commentTextView.text = "\(postDetail.commentCount) Comments"
            postCell.footer.shareTextView.text = "\(postDetail.shareCount) Shares"
        default:
            print()
        }
    }
    
    func newsCell(from newsDetail: NewsDetails, in newsCell: Any){
        
        switch newsCell {
        case let newsCell as NewsFeedTableViewCell:
            newsCell.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            newsCell.header.informationView.text = "LYK"
            newsCell.header.informationView.text?.append("\n\(Utility.lykTime(from: newsDetail.feedTime).timeAgoSince())")
            newsCell.body.titleView.text = newsDetail.newsTitle
            newsCell.body.urlString = newsDetail.newsImageUrl.removingWhitespaces()
            newsCell.body.newsDescriptionView.text = newsDetail.newsDescription
            newsCell.body.sourceTextView.text = "Source: \(newsDetail.newsSource)"
            newsCell.body.poweredByView.text = newsDetail.poweredBy
            newsCell.backgroundColor = UIColor.white
            newsCell.footer.likeTextView.text = "\(newsDetail.likeCount) Likes"
            newsCell.footer.commentTextView.text = "\(newsDetail.commentCount) Comments"
            newsCell.footer.shareTextView.text = "\(newsDetail.shareCount) Shares"
        case let newsCell as NewsFeedCollectionViewCell:
            newsCell.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
            newsCell.header.informationView.text = "LYK"
            newsCell.header.informationView.text?.append("\n\(Utility.lykTime(from: newsDetail.feedTime).timeAgoSince())")
            newsCell.body.titleView.text = newsDetail.newsTitle
            newsCell.body.urlString = newsDetail.newsImageUrl.removingWhitespaces()
            newsCell.body.newsDescriptionView.text = newsDetail.newsDescription
            newsCell.body.sourceTextView.text = "Source: \(newsDetail.newsSource)"
            newsCell.body.poweredByView.text = newsDetail.poweredBy
            newsCell.backgroundColor = UIColor.white
            newsCell.footer.likeTextView.text = "\(newsDetail.likeCount) Likes"
            newsCell.footer.commentTextView.text = "\(newsDetail.commentCount) Comments"
            newsCell.footer.shareTextView.text = "\(newsDetail.shareCount) Shares"
        default:
            print()
        }
    }
    
}

class PostDetails: Codable{
    var commentCount: String
    var createdBy: LykUser
    var createdOn: String
    var feedTime: String
    var imageUrl: String?
    var likeCount: String
    var myLike: Int
    var placeName: String?
    var postId: String
    var postLat: String?
    var postLng: String?
    var privateCount: String
    var shareCount: String
    var title: String
    var userId: String
    
}

class NewsDetails: Codable{
    var commentCount: String
    var feedTime: String
    var likeCount: String
    var mobReduceImg: String
    var myLike: Int
    var newsDescription: String
    var newsId: String
    var newsImageUrl: String
    var newsLink: String
    var newsSource: String
    var newsTitle: String
    var poweredBy: String
    var shareCount: String
    var webOrgimage: String
}

