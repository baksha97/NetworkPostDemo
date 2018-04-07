//
//  LykUser.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

class LykUser: Codable{
    var contactNo: String?
    var countryCode: String?
    var coverUrl: String?
    var email: String?
    var imageUrl: String?
    
    var firstName: String
    var isFriend: Int
    var userId: String
}
