//
//  CollectionViewController.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/8/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //set of items
    var data = [Any]()
    
    //TODO: UPDATE WITH TABLEVIEW CONFIGURATION
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(flowLayout, animated: true)
        self.collectionView!.register(PostFeedCollectionViewCell.self, forCellWithReuseIdentifier: PostObjectManager.shared.postCellId)
        self.collectionView!.register(NewsFeedCollectionViewCell.self, forCellWithReuseIdentifier: PostObjectManager.shared.newsCellId)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    //seperator spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    //attempting to approximate the size of each individual cell of collection view since the automatic resizing is not working as intended
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let approxWidthOfTitle = view.frame.width
        let size = CGSize(width: approxWidthOfTitle, height: 1000) //high height to start
        let titleAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)] // font of the title
        let newDescriptionAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)] //font of the news description
        let item = data[indexPath.row]
        switch item {
            case let item as PostDetails:
                let estimatedTitleFrame = NSString(string: item.title)
                    .boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: titleAttributes, context: nil)
                if item.imageUrl != nil{
                    // title frame + buttons/other cell items + imageview itself + padding for text
                    return CGSize(width: view.bounds.width, height: estimatedTitleFrame.height + 150 + 12 + 300 + 24)
                }
                // title frame + buttons/other cell items + padding for text
                return CGSize(width: view.bounds.width, height: estimatedTitleFrame.height + 150 + 12)
            case let item as NewsDetails:
                let estimatedTitleFrame = NSString(string: item.newsTitle)
                    .boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: titleAttributes, context: nil)
                let estimatedDescriptionFrameHeight = NSString(string: item.newsTitle)
                    .boundingRect(with: size, options: .usesLineFragmentOrigin,
                                  attributes: newDescriptionAttributes, context: nil)
                    .height + 12 //text container insets
                return CGSize(width: view.bounds.width,
                              // title frame + description height +  buttons/other cell items + padding for text
                              height: estimatedTitleFrame.height + estimatedDescriptionFrameHeight + 475 + 12)
            default:
                return CGSize(width: view.bounds.width, height: 0)
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = data[indexPath.row]
        
        let postCell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: PostObjectManager.shared.postCellId, for: indexPath) as! PostFeedCollectionViewCell
        let newsCell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: PostObjectManager.shared.newsCellId, for: indexPath) as! NewsFeedCollectionViewCell
        
        switch item {
        case let feedItem as PostDetails:
            PostObjectManager.shared.postCell(from: feedItem, in: postCell)
            return postCell
        case let feedItem as NewsDetails:
            PostObjectManager.shared.newsCell(from: feedItem, in: newsCell)
            return newsCell
        default:
            print("UNSUPPORTED")
        }
        
        return UICollectionViewCell()
    }

    
    func retrieveData(){
        LykAppService.shared.retrieveAll(completion: { (items) in
            if let items = items{
                self.data = items
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        })
    }

}
