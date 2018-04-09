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
    
    //perform networking actions - this would be replaced by the correct network servicing application of LykApp
    //Or this may be used with a seperate initialization/configuration method based on the current user logged in
    private init(){
        url = URL(string: "https://api.lykapp.com/lykjwt/index.php?/relatedData/getHomeFeed")!
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        postString = "userId=3196&offset=0&limit=25" //Param: {"userId":"3196",  "offset": 0, "limit":25 }
        request.httpBody = postString.data(using: .utf8)
    }
    
    //gets all items into one [Any] array.
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
    
    //gets items as seperate arrays
    //this would be useful for adding a "news" section and a "post" section.
    public func retrievePostAndNews(completion: @escaping([PostDetails]?, [NewsDetails]?) -> Void){
        runURLTask(completion: { (data) in
            
            var postArray = [PostDetails]()
            var newsArray = [NewsDetails]()
            
            if let data = data{
                let json = try! JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as! [String:Any]
                let feed = self.responseFeed(from: json)
                //HANDLE OBJECTS
                
                if let posts = self.query(feed: feed, for: .posts) as? [PostDetails]{
                    postArray = posts
                }
                if let news = self.query(feed: feed, for: .news) as? [NewsDetails]{
                    newsArray = news
                }
                completion(postArray, newsArray)
            }else{
                print("There was an error retrieving your feed items.")
            }
        })
    }
    
    //performs url task
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
    
    //parse response
    private func responseFeed(from json: [String: Any]) -> NSArray {
        let response = json["response"] as! [String: Any]
        return (response["feeds"] as! NSArray)
    }
    
    //seeks specific type based on enums
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
                        let post = try self.decode(as: PostDetails.self, data: details as! [String : Any])
                        items.append(post)
                        //print(details)
                    } catch{
                        print(error)
                }
                case "news":
                    //print("\(type)")
                    do{
                        let object = try self.decode(as: NewsDetails.self, data: details as! [String : Any])
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
    //seeks specific type based on multiple enums
    private func query(feed: NSArray, for itemType: LykItemType) -> [Any]?{
        
        switch itemType {
        case .posts:
            var items = [PostDetails]()
            for item in feed{
                let post = item as! [String: Any]
                let type = post["type"] as! String
                if let details = post["details"] as Any?{
                    if(type == "post"){
                        print("\(type)")
                        do{
                            let post = try self.decode(as: PostDetails.self, data: details as! [String : Any])
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
            var items = [NewsDetails]()
            for item in feed{
                let post = item as! [String: Any]
                let type = post["type"] as! String
                if let details = post["details"] as Any?{
                    if(type == "news"){
                        print("\(type)")
                        do{
                            let object = try self.decode(as: NewsDetails.self, data: details as! [String : Any])
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
    
    //decodes json to swift objects
    private func decode<T: Decodable>(as objectType: T.Type, data: [String: Any]) throws -> T{
        let documentData = try JSONSerialization.data(withJSONObject: data, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        return decodedObject
    }
    
    
    let dateFormatter = DateFormatter()
    //converts like specific database time to contextual time
    static func lykTime(from lykDateString: String) -> Date{
        //yyyy-dd-MM HH:mm:ss: lyk format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // TODO: CHANGE TO CONTEXT
        let date = dateFormatter.date(from:lykDateString)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date!)
        return calendar.date(from:components)!
    }
}
