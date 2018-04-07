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
        self.tableView.register(NewsFeedCell.self, forCellReuseIdentifier: "NewsFeedCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        retrieveData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = data[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell") as! NewsFeedCell
        switch item {
            case let feedItem as RawPostDetails:
                cell.body.titleView.text = feedItem.title
            case let feedItem as RawNewsDetails:
                cell.body.titleView.text = feedItem.newsTitle
                if let url = URL(string: feedItem.newsImageUrl){
                    //cell.body.mainImageView.downloadedFrom(url: url, contentMode: nil)
                    cell.body.mainImageView.image = UIImage(named: "placeholder.png")
                }
                cell.body.newsDescriptionView.text = feedItem.newsDescription
                cell.body.poweredByView.text = feedItem.poweredBy
            default:
                print("UNSUPPORTED")
        }
        
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    
    
    func retrieveData(){
        LykAppService.shared.retrieveAll(completion: { (items) in
            if let items = items{
                self.data = items
                print(items.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.layoutSubviews()
                }
            }
        })
    }
}
