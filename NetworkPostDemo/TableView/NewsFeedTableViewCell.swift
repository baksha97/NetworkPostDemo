//
//  HomeFeedCell.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/6/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell{
    var newsView = NewsView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(newsView)
        newsView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



