//
//  HomeFeedCell.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/6/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell{
    var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var nameView: UITextView = {
        var label = UITextView()
        return label
    }()
    var timeView: UITextView = {
        var textView = UITextView()
        return textView
    }()

    var body: NewsCellBodyView = NewsCellBodyView()
    var footer: NewsCellFooterView = NewsCellFooterView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(body)
        self.addSubview(footer)
        body.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: footer.topAnchor, right: self.rightAnchor)
        footer.anchor(top: body.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



