//
//  PostView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/10/18.
//  Copyright © 2018 baksha97. All rights reserved.
//
import UIKit

class PostView: UIView{
    
    //MARK: Static URLS
    let lykImageUrl = "http://52.90.18.119/lykjwt/uploads/lyk.png"
    let postBaseUrl = "https://www.lykapp.com/lykjwt/uploads/images/"
    
    var header: FeedCellHeaderView = FeedCellHeaderView()
    var body: PostCellBodyView = PostCellBodyView()
    var footer: FeedCellFooterView = FeedCellFooterView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(header)
        self.addSubview(body)
        self.addSubview(footer)
        header.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor,
                      topConstant: 12, leftConstant: 12
        )
        body.anchor(top: header.bottomAnchor, left: self.leftAnchor, bottom: footer.topAnchor, right: self.rightAnchor)
        footer.anchor(top: body.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor,
                      bottomConstant: 12
        )
    }
    
    func configure(item: PostDetails){
        print(item.title)
        header.informationView.text = item.createdBy.firstName
        if let profileImageUrl = item.createdBy.imageUrl{
            self.header.profileImageView.loadAsyncFrom(url: profileImageUrl, placeholder: nil)
        }else{
            self.header.profileImageView.loadAsyncFrom(url: lykImageUrl, placeholder: nil)
        }
        self.header.informationView.text?.append("\n\(LykAppService.lykTime(from: item.feedTime).timeAgoSince())")
        
        if item.title == "" {
            // currently in the Lyk URL data pull, the "SHARED" post types are recieved as post and is not automatically differientiated with
            // the response of { type = ___ [currently set as post] }
            self.body.removeTitle()
        }else{
            self.body.titleView.text = item.title
        }
        
        if let feedItemImageUrl = item.imageUrl{
            self.body.urlString = "\(postBaseUrl)\(feedItemImageUrl)"
        }else{
            self.body.removeImageView()
        }
        self.backgroundColor = UIColor.white
        self.footer.likeTextView.text = "\(item.likeCount) Likes"
        self.footer.commentTextView.text = "\(item.commentCount) Comments"
        self.footer.shareTextView.text = "\(item.shareCount) Shares"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
