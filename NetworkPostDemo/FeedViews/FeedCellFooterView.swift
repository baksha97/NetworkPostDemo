//
//  NewsCellFooterView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/7/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

//footer to be used for all feed cells
class FeedCellFooterView: UIView{
    
    private let buttonWidth: CGFloat = 54.0
    private let buttonHeight: CGFloat = 49.5
    
    //plausibly better to create a subclass with the consistent constant attributes
    var likeTextView: UITextView = {
        var textView = UITextView()
        let attributes = NSMutableAttributedString(string: " ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)])
        textView.attributedText = attributes
        textView.textContainerInset = UIEdgeInsetsMake(0, 12, 0, 0);
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var commentTextView: UITextView = {
        var textView = UITextView()
        let attributes = NSMutableAttributedString(string: " ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)])
        textView.attributedText = attributes
        textView.textContainerInset = UIEdgeInsetsMake(0, 12, 0, 0);
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var shareTextView: UITextView = {
        var textView = UITextView()
        let attributes = NSMutableAttributedString(string: " ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)])
        textView.attributedText = attributes
        textView.textContainerInset = UIEdgeInsetsMake(0, 12, 4, 0);
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    //plausibly better to create a subclass with the consistent constant attributes
    var likeButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(12, 12, 4, 0)
        //button.setTitle("Like", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setImage(#imageLiteral(resourceName: "likeButton").imageWithInsets(insetDimen: 40) , for: UIControlState.normal) //insets allow room within the border itself
        button.imageView?.layer.borderColor = UIColor(red: 255/255, green: 85/255, blue: 73/255, alpha: 1.0).cgColor
        button.imageView?.layer.borderWidth = 2.0
        button.imageView?.layer.cornerRadius = 5
        button.imageView?.layer.masksToBounds = true
        return button
    }()
    var commentButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(12, 12, 4, 0)
        //button.setTitle("Comment", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setImage(#imageLiteral(resourceName: "commentButton").imageWithInsets(insetDimen: 40), for: UIControlState.normal) //insets allow room within the border itself
        button.imageView?.layer.borderColor = UIColor(red: 255/255, green: 85/255, blue: 73/255, alpha: 1.0).cgColor
        button.imageView?.layer.borderWidth = 2.0
        button.imageView?.layer.cornerRadius = 5
        button.imageView?.layer.masksToBounds = true
        return button
    }()
    var shareButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(12, 12, 4, 0)
        //button.setTitle("Share", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setImage(#imageLiteral(resourceName: "shareButton").imageWithInsets(insetDimen: 40), for: UIControlState.normal) //insets allow room within the border itself
        button.imageView?.layer.borderColor = UIColor(red: 255/255, green: 85/255, blue: 73/255, alpha: 1.0).cgColor
        button.imageView?.layer.borderWidth = 2.0
        button.imageView?.layer.cornerRadius = 5
        button.imageView?.layer.masksToBounds = true
        return button
    }()
    var optionsButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 12)
        button.setTitle("...", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        //button.setImage(#imageLiteral(resourceName: "optionsButton"), for: UIControlState.normal)
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
        likeTextView.anchor(top: self.topAnchor,
                            left: self.leftAnchor,
                            bottom: interactionBarTop,
                            right: commentTextView.leftAnchor
        )
        commentTextView.anchor(top: self.topAnchor,
                               left: likeTextView.rightAnchor,
                               bottom: interactionBarTop,
                               right: shareTextView.leftAnchor
        )
        shareTextView.anchor(top: self.topAnchor,
                             left: commentTextView.rightAnchor,
                             bottom: interactionBarTop
        )
        
        let informationBarBottom = likeTextView.bottomAnchor
        likeButton.anchor(top: informationBarBottom,
                          left: self.leftAnchor,
                          //bottom: self.bottomAnchor,
                          right: commentButton.leftAnchor,
                          widthConstant: buttonWidth, heightConstant: buttonHeight
        )
        commentButton.anchor(top: informationBarBottom,
                             left: likeButton.rightAnchor,
                             //bottom: self.bottomAnchor,
                             right:shareButton.leftAnchor,
                             widthConstant: buttonWidth, heightConstant: buttonHeight
        )
        shareButton.anchor(top: informationBarBottom,
                           left: commentButton.rightAnchor,
                           //bottom: self.bottomAnchor,
                           widthConstant: buttonWidth, heightConstant: buttonHeight
        )
        
        optionsButton.anchor(top: informationBarBottom,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             widthConstant: buttonWidth, heightConstant: buttonHeight
        )
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
