//
//  NewsCellHeaderView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/7/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class NewsCellHeaderView: UIView{
    var profileImageView: RoundedImageView = {
        var imageView = RoundedImageView()
        //
        imageView.image = (#imageLiteral(resourceName: "placeholder"))
        return imageView
    }()
    var nameTextView: UITextView = {
        var textView = UITextView()
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var timeTextView: UITextView = {
        var textView = UITextView()
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
        self.addSubview(profileImageView)
        self.addSubview(nameTextView)
        self.addSubview(timeTextView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nameTextView.leftAnchor)
        nameTextView.anchor(top: self.topAnchor, left: profileImageView.rightAnchor,
                                   bottom: timeTextView.topAnchor, right: self.rightAnchor)
        timeTextView.anchor(top: nameTextView.bottomAnchor, left: profileImageView.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

