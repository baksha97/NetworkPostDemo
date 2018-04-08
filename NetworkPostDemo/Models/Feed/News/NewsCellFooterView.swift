//
//  NewsCellFooterView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/7/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class NewsCellFooterView: UIView{
    var likeTextView: UITextView = {
        var textView = UITextView()
        textView.textContainerInset = UIEdgeInsetsMake(0, 12, 0, 0);
        //textView.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0)
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var commentTextView: UITextView = {
        var textView = UITextView()
        textView.textContainerInset = UIEdgeInsetsMake(0, 12, 0, 0);
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var shareTextView: UITextView = {
        var textView = UITextView()
        textView.textContainerInset = UIEdgeInsetsMake(0, 12, 0, 0);
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var likeButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0)
        button.setTitle("Like", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    var commentButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0)
        button.setTitle("Comment", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    var shareButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0)
        button.setTitle("Share", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    var optionsButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 12, 12)
        button.setTitle("...", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeTextView)
        self.addSubview(commentTextView)
        self.addSubview(shareTextView)
        self.addSubview(likeButton)
        self.addSubview(commentButton)
        self.addSubview(shareButton)
        self.addSubview(optionsButton)
        
        let interactionBarTop = likeButton.topAnchor
        likeTextView.anchor(top: self.topAnchor, left: self.leftAnchor,
                            bottom: interactionBarTop, right: commentTextView.leftAnchor)
        commentTextView.anchor(top: self.topAnchor, left: likeTextView.rightAnchor,
                               bottom: interactionBarTop , right: shareTextView.leftAnchor)
        shareTextView.anchor(top: self.topAnchor, left: commentTextView.rightAnchor,
                             bottom: interactionBarTop)
        let informationBarBottom = likeTextView.bottomAnchor
        likeButton.anchor(top: informationBarBottom, left: self.leftAnchor,
                          bottom: self.bottomAnchor, right: commentButton.leftAnchor,
                          leftConstant: 10.0)
        commentButton.anchor(top: informationBarBottom, left: likeButton.rightAnchor, bottom: self.bottomAnchor, right:
        shareButton.leftAnchor)
        shareButton.anchor(top: informationBarBottom, left: commentButton.rightAnchor, bottom: self.bottomAnchor)
        optionsButton.anchor(top: informationBarBottom, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
