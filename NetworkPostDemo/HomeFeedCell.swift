//
//  HomeFeedCell.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/6/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class HomeFeedCell: UITableViewCell{
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
    var titleView: UITextView = {
        var textView = UITextView()
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    var newsDescriptionView: UITextView = {
        var textView = UITextView()
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    
//    var header: UIView = {
//        var view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleView)
        self.addSubview(mainImageView)
        self.addSubview(newsDescriptionView)
        
        titleView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.mainImageView.topAnchor,
                         right: self.rightAnchor)
        mainImageView.anchor(top: titleView.bottomAnchor, left: self.leftAnchor,
                             bottom: newsDescriptionView.topAnchor, right: self.rightAnchor)
        newsDescriptionView.anchor(top: mainImageView.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)

//
    
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

