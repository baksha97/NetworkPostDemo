//
//  NewsBodyView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/7/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class NewsCellBodyView: UIView{
    
    
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
    var newsDescriptionView: UITextView = {
        var textView = UITextView()
        let attributes = NSMutableAttributedString(string: " ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        textView.attributedText = attributes
        textView.textContainerInset = UIEdgeInsetsMake(8, 12, 8, 12)
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var sourceTextView: UITextView = {
        var textView = UITextView()
        let attributes = NSMutableAttributedString(string: "SOURCE", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        textView.attributedText = attributes
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.red
        textView.textContainerInset = UIEdgeInsetsMake(8, 12, 8, 12)
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    var poweredByView: UITextView = {
        var textView = UITextView()
        let attributes = NSMutableAttributedString(string: " ",
                                                   attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                                                                NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        textView.attributedText = attributes
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)
        self.addSubview(mainImageView)
        self.addSubview(newsDescriptionView)
        self.addSubview(poweredByView)
        titleView.anchor(top: self.topAnchor, left: self.leftAnchor,
                         bottom: mainImageView.topAnchor, right: self.rightAnchor)
        mainImageView.anchor(top: titleView.bottomAnchor, left: self.leftAnchor,
                             bottom: newsDescriptionView.topAnchor, right: self.rightAnchor)
        mainImageView.addSubview(sourceTextView)
        sourceTextView.anchor(bottom: mainImageView.bottomAnchor, right: mainImageView.rightAnchor)
        newsDescriptionView.anchor(top: mainImageView.bottomAnchor, left: self.leftAnchor,
                                   bottom: poweredByView.topAnchor, right: self.rightAnchor)
        poweredByView.anchor(top: newsDescriptionView.bottomAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
