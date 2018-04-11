//
//  UIImageView.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/7/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

extension UIImageView {
    //asyc image view downloading...
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode?, completion: @escaping(Bool) -> Void) {
    
        if let mode = mode{
            contentMode = mode
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                completion(true)
            }
            }.resume()
    }
    
}
