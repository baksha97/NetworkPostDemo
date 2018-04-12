//
//  PostFeedCollectionViewCell.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/8/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class PostFeedCollectionViewCell: UICollectionViewCell{
    
    var view = PostFeedCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(view)
        view.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
