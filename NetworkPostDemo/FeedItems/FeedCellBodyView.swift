//
//  FeedCellBodyView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/11/18.
//  Copyright © 2018 baksha97. All rights reserved.
//
import UIKit

class FeedCellBodyView: UIView{
    var urlString: String? {
        didSet {
            if let url = urlString {
                mainImageView.loadAsyncFrom(url: url, placeholder: nil, completion: { (completed) in
                    self.layoutSubviews()
                })
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
        imageView.contentMode = .scaleAspectFit // collectionview has an easier time displaying the correct cell height if we have a somewhat consistent size
        imageView.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 73/255, alpha: 0.2)// lyk app color //UIColor(white: 0.98, alpha: 1)
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)
        self.addSubview(mainImageView)
//        titleView.anchor(top: self.topAnchor, left: self.leftAnchor,
//                         bottom: mainImageView.topAnchor, right: self.rightAnchor)
//        mainImageView.anchor(top: titleView.bottomAnchor, left: self.leftAnchor,
//                             bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
}
