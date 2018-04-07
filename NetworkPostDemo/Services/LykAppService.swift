//
//  LykAppService.swift
//  NetworkPostDemo
//
//  Created by Loaner on 4/5/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

class LykAppService{
    static let shared = LykAppService()
    
    
    var url: URL
    var request: URLRequest    //Param: {"userId":"3196",  "offset": 0, "limit":25 }
    let postString: String
    
    private init(){
        url = URL(string: "https://api.lykapp.com/lykjwt/index.php?/relatedData/getHomeFeed")!
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        postString = "userId=3196&offset=0&limit=25" //Param: {"userId":"3196",  "offset": 0, "limit":25 }
        request.httpBody = postString.data(using: .utf8)
    }
    
    //TODO: add error
    public func retrieveAll(completion: @escaping([Any]?) -> Void){
        runURLTask(completion: { (data) in
            
            var array = [Any]()
            
            if let data = data{
                let json = try! JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as! [String:Any]
                let feed = self.responseFeed(from: json)
                //HANDLE OBJECTS
                
                if let feedItems = self.query(feed: feed, for: [.posts, .news]){
                    array = feedItems
                }
                completion(array)
            }else{
                print("There was an error retrieving your feed items.")
            }
        })
    }
    
    //TODO: add error
    public func retrievePostAndNews(completion: @escaping([RawPostDetails]?, [RawNewsDetails]?) -> Void){
        runURLTask(completion: { (data) in
            
            var postArray = [RawPostDetails]()
            var newsArray = [RawNewsDetails]()
            
            if let data = data{
                let json = try! JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as! [String:Any]
                let feed = self.responseFeed(from: json)
                //HANDLE OBJECTS
                
                if let posts = self.query(feed: feed, for: .posts) as? [RawPostDetails]{
                    postArray = posts
                }
                if let news = self.query(feed: feed, for: .news) as? [RawNewsDetails]{
                    newsArray = news
                }
                completion(postArray, newsArray)
            }else{
                print("There was an error retrieving your feed items.")
            }
        })
    }
    
    private func runURLTask(completion: @escaping(Data?) -> Void){
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {  // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {    // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(httpStatus)")
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            
            completion(data)
        }
        task.resume()
    }
    
    private func responseFeed(from json: [String: Any]) -> NSArray {
        let response = json["response"] as! [String: Any]
        return (response["feeds"] as! NSArray)
    }
    
    private func query(feed: NSArray, for itemTypes: [LykItemType]) -> [Any]?{
        
        var items = [Any]()
        for item in feed{
            let post = item as! [String: Any]
            let type = post["type"] as! String
            if let details = post["details"] as Any?{
                switch type {
                case "post":
                    //print("\(type)")
                    do{
                        let post = try self.decode(as: RawPostDetails.self, data: details as! [String : Any])
                        items.append(post)
                        //print(details)
                    } catch{
                        print(error)
                }
                case "news":
                    //print("\(type)")
                    do{
                        let object = try self.decode(as: RawNewsDetails.self, data: details as! [String : Any])
                        items.append(object)
                        //print(details)
                    } catch{
                        print(error)
                    }
                default:
                    print("Unsupported home feed type: \(type)")
                }
            }
        }
        return items
    }
    
    private func query(feed: NSArray, for itemType: LykItemType) -> [Any]?{
        
        switch itemType {
        case .posts:
            var items = [RawPostDetails]()
            for item in feed{
                let post = item as! [String: Any]
                let type = post["type"] as! String
                if let details = post["details"] as Any?{
                    if(type == "post"){
                        print("\(type)")
                        do{
                            let post = try self.decode(as: RawPostDetails.self, data: details as! [String : Any])
                            items.append(post)
                            print(details)
                        } catch{
                            print(error)
                        }
                    }
                }
            }
            return items
            
        case .news:
            var items = [RawNewsDetails]()
            for item in feed{
                let post = item as! [String: Any]
                let type = post["type"] as! String
                if let details = post["details"] as Any?{
                    if(type == "news"){
                        print("\(type)")
                        do{
                            let object = try self.decode(as: RawNewsDetails.self, data: details as! [String : Any])
                            items.append(object)
                         //   print(details)
                        } catch{
                            print(error)
                        }
                    }
                }
            }
            return items
        }
        
    }
    
    private func decode<T: Decodable>(as objectType: T.Type, data: [String: Any]) throws -> T{
        
        let documentData = try JSONSerialization.data(withJSONObject: data, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
}
