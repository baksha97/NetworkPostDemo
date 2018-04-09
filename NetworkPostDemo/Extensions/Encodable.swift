//
//  Encodable.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

enum EncodingError: Error {
    case encodingError
}

//database encoding -if needed. 
extension Encodable{
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        ///might need future modification
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String: Any] else {throw EncodingError.encodingError}
        
        for key in keys{
            json[key] = nil
        }
        return json
    }
}
