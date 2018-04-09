//
//  PostCellBodyView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/8/18.
//  Copyright © 2018 baksha97. All rights reserved.
//
import UIKit

class PostCellBodyView: UIView{
    
    
    var urlString: String? {
        didSet {
            if let url = urlString {
                mainImageView.loadAsyncFrom(url: url, placeholder: nil)
            }
        }
    }
    
    var titleView: UITextView = {
        var textView = UITextView()
        let attributes = NSMutableAttributedString(string: " ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)])
        textView.attributedText = attributes
        textView.textContainerInset = UIEdgeInsetsMake(12, 12, 12, 12)
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var mainImageView: AyncImageView = {
        var imageView = AyncImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //for when a post does not have an image --- it may be more appropriate to create an entirely new cell
    func removeImageView(){
        self.mainImageView.isHidden = true
    }
    
    func removeTitle(){
       // self.titleView.removeFromSuperview()
        self.titleView.removeFromSuperview()
        mainImageView.anchor(top: self.topAnchor,
                             left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)
        self.addSubview(mainImageView)
        titleView.anchor(top: self.topAnchor, left: self.leftAnchor,
                         bottom: mainImageView.topAnchor, right: self.rightAnchor)
        mainImageView.anchor(top: titleView.bottomAnchor, left: self.leftAnchor,
                             bottom: self.bottomAnchor, right: self.rightAnchor)
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
