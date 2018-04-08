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
    var nameLabel: UILabel = {
        var label = UILabel()
        let attributes = NSMutableAttributedString(string: " ",
                                                   attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        label.attributedText = attributes
        return label
    }()
    var timeTextView: UITextView = {
        var textView = UITextView()
        let attributes = NSMutableAttributedString(string: " ",
                                                   attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
                                                                NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        textView.attributedText = attributes
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        self.addSubview(timeTextView)
        self.frame = self.frame.insetBy(dx: 10.0, dy: 10.0)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, widthConstant: 50, heightConstant: 50)
        nameLabel.anchor(top: self.topAnchor, left: profileImageView.rightAnchor,
                                   bottom: timeTextView.topAnchor, right: self.rightAnchor)
        timeTextView.anchor(top: nameLabel.bottomAnchor, left: profileImageView.rightAnchor,
                            bottom: self.bottomAnchor, right: self.rightAnchor)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

