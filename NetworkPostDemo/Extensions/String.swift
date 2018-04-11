//
//  String.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/10/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

//needed to fix items in database that have " "'s in the URLs.
extension String {
    func replaceUrlSpaces() -> String {
        //%20
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
