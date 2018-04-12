//
//  PostFeedCellView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/11/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class PostFeedCellView: FeedCellView{
    
    var body = PostFeedCellBodyView()
    
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

class PostFeedCellBodyView: FeedCellBodyView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
