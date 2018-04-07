//
//  ViewController.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var data = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(HomeFeedCell.self, forCellReuseIdentifier: "HomeFeedCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        retrieveData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = data[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HomeFeedCell") as! HomeFeedCell
        
        switch item {
            case let feedItem as RawPostDetails:
                cell.titleView.text = feedItem.title
            case let feedItem as RawNewsDetails:
                cell.titleView.text = feedItem.newsTitle
                if let url = URL(string: feedItem.newsImageUrl){
                    cell.mainImageView.downloadedFrom(url: url, contentMode: nil)
                }
                cell.newsDescriptionView.text = feedItem.newsDescription
            default:
                print("UNSUPPORTED")
        }
        
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    func retrieveData(){
        LykAppService.shared.retrieveAll(completion: { (items) in
            if let items = items{
                self.data = items
                print(items.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
//                for item in items{
//                    switch item {
//                    case let feedItem as RawPostDetails:
//                        print("POST \(feedItem.title)")
//                    case _ as RawNewsDetails:
//                        print("news")
//                    default:
//                        print("UNSUPPORTED")
//                    }
//                }
            }
        })
    }
}
