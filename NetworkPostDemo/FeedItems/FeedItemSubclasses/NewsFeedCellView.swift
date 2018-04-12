//
//  NewsFeedCellView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/11/18.
//  Copyright © 2018 baksha97. All rights reserved.
//
import UIKit

class NewsFeedCellView: FeedCellView{
    
    var body: NewsFeedCellBodyView = NewsFeedCellBodyView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(header)
        self.addSubview(body)
        self.addSubview(footer)
        header.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor,
                      topConstant: 12, leftConstant: 12
        )
        body.anchor(top: header.bottomAnchor, left: self.leftAnchor, bottom: footer.topAnchor, right: self.rightAnchor)
        footer.anchor(top: body.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor,
                      bottomConstant: 12
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class NewsFeedCellBodyView: FeedCellBodyView{
    
    var height: CGFloat? {
        didSet {
            //  self.anchorImageView()  --- BUG, CURRENTLY NOT WORKING AS INTENDED
        }
    }
    var width: CGFloat? {
        didSet {
            // self.anchorImageView() --- BUG, CURRENTLY NOT WORKING AS INTENDED
        }
    }
    
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
        let attributes = NSMutableAttributedString(string: "Source: ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)])
        textView.attributedText = attributes
        textView.textColor = UIColor.white
        //    R: 255 G: 83 B: 73
        textView.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 73/255, alpha: 1.0)//lyk app color
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
        //setupViews()
        self.addSubview(titleView)
        self.addSubview(mainImageView)
        self.addSubview(newsDescriptionView)
        self.addSubview(poweredByView)
        titleView.anchor(top: self.topAnchor, left: self.leftAnchor,
                         bottom: mainImageView.topAnchor, right: self.rightAnchor)
        
        mainImageView.anchor(top: titleView.bottomAnchor, left: self.leftAnchor,
                             bottom: newsDescriptionView.topAnchor, right: self.rightAnchor
        )
        
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
