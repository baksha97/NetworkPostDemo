//
//  NewsCellHeaderView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/7/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class FeedCellHeaderView: UIView{
    var profileImageView: RoundedImageView = {
        var imageView = RoundedImageView()
        return imageView
    }()
    var informationView: UITextView = {
        var textView = UITextView()
        let attributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)]
        textView.attributedText = NSAttributedString(string: " ", attributes: attributes)
        textView.textContainerInset = UIEdgeInsetsMake(20, 4, 0, 0)
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileImageView)
        self.addSubview(informationView)
        
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, widthConstant: 75, heightConstant: 75)
        informationView.anchor(top: self.topAnchor, left: profileImageView.rightAnchor,
                                   bottom: self.bottomAnchor, right: self.rightAnchor)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

