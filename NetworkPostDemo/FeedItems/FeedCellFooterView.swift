//
//  NewsCellFooterView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/7/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class FeedButton: UIButton{
    
    init(insets: UIEdgeInsets, image: UIImage){
        super.init(frame: .zero)
        contentEdgeInsets = insets
        setTitleColor(UIColor.red, for: .normal)
        setImage(image.imageWithInsets(insetDimen: 40) , for: UIControlState.normal) //insets allow room within the border itself
        imageView?.layer.borderColor = UIColor(red: 255/255, green: 85/255, blue: 73/255, alpha: 1.0).cgColor
        imageView?.layer.borderWidth = 2.0
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

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
    
    //created a subclass with the consistent constant attributes
    var likeButton: FeedButton = {
        var insets = UIEdgeInsetsMake(12, 12, 4, 0)
        var button = FeedButton(insets: insets, image: #imageLiteral(resourceName: "likeButton"))
        return button
    }()
    var commentButton: FeedButton = {
        var insets = UIEdgeInsetsMake(12, 12, 4, 0)
        var button = FeedButton(insets: insets, image: #imageLiteral(resourceName: "commentButton"))
        return button
    }()
    var shareButton: FeedButton = {
        var insets = UIEdgeInsetsMake(12, 12, 4, 0)
        var button = FeedButton(insets: insets, image: #imageLiteral(resourceName: "shareButton"))
        return button
    }()
    
    var optionsButton: UIButton = {
        var button = UIButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 12)
        button.setTitle("...", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        //button.setImage(#imageLiteral(resourceName: "optionsButton"), for: UIControlState.normal)
        //the options image does not match the dimensions of the other buttons - causing a deformity.
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
