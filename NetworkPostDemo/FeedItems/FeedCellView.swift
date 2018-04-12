//
//  HomeFeedCellView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/11/18.
//  Copyright © 2018 baksha97. All rights reserved.
//
import UIKit

class FeedCellView: UIView{
    var header: FeedCellHeaderView = FeedCellHeaderView()
    var footer: FeedCellFooterView = FeedCellFooterView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
