//
//  String.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/7/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
