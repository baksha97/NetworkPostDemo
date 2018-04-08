//
//  Utility.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/8/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

class Utility{
    let dateFormatter = DateFormatter()
    
    static func lykTime(from lykDateString: String) -> Date{
        //yyyy-dd-MM HH:mm:ss: lyk format
        print(lykDateString.debugDescription)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX") // TODO: CHANGE TO CONTEXT
        let date = dateFormatter.date(from:lykDateString)
    
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date!)
        return calendar.date(from:components)!
    }
}
