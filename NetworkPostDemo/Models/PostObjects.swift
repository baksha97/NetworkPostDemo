//
//  PostObjects.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

//type enum for LykAppService
enum LykItemType: String{
    case news
    case posts
}

//object used by database

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

