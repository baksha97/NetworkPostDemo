//
//  AyncImageView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/8/18.
//  Copyright © 2018 baksha97. All rights reserved.
//---Stackoverflow suggestion.

import UIKit

//MARK: - 'asyncImagesCashArray' is a global varible cashed UIImage
var asyncImagesCashArray = NSCache<NSString, UIImage>()

class AyncImageView: UIImageView {
    
    //MARK: - Variables
    private var currentURL: NSString?
    
    //MARK: - Public Methods
    
    func loadAsyncFrom(url: String, placeholder: UIImage?, completion: (@escaping(Bool) -> Void)){
        let imageURL = url as NSString
        if let cashedImage = asyncImagesCashArray.object(forKey: imageURL) {
            image = cashedImage
            return
        }
        image = placeholder
        currentURL = imageURL
        guard let requestURL = URL(string: url) else { image = placeholder; return }
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                if error == nil {
                    if let imageData = data {
                        if self?.currentURL == imageURL {
                            if let imageToPresent = UIImage(data: imageData) {
                                asyncImagesCashArray.setObject(imageToPresent, forKey: imageURL)
                                self?.image = imageToPresent
                                completion(true)
                            } else {
                                self?.image = placeholder
                            }
                        }
                    } else {
                        self?.image = placeholder
                    }
                } else {
                    self?.image = placeholder
                }
            }
            }.resume()
    }
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }

}
