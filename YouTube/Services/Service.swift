//
//  Service.swift
//  YouTube
//
//  Created by Tobi on 2/5/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

// если API_KEY не работает, пожалуйста поменяйте. так как превысили лимит запроса API_KEY может не отвечать. поэтому я взял 2 API_KEY

let API_KEY = "AIzaSyBYZhkXD4KVFCKzwHqncDGb0mu9VEzFtEM"  // kerezov.t.a@gmail.com
//let API_KEY = "AIzaSyAyJASwLaPxyVSGPvSZlruiqG-_aku3QWg"  // gorgeousman.312@gmail.com

class Service: NSObject {
    
    static let instance = Service()

    //MARK: -Search Video
    
    func getListOfItems(searchText: String, onCompletion: @escaping (([Item]) -> Void), onError: @escaping ((String?) -> Void)) {
        
        let APIaddress = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=20&order=Relevance&q=\(searchText)&type=video&key=\(API_KEY)"
    
        Alamofire.request(APIaddress).responseJSON { (response) in
            if let result = response.result.value as? [String: AnyObject] {
                if let data = result["items"] as? [[String: AnyObject]]{
                    let items = Mapper<Item>().mapArray(JSONArray: data)
                    onCompletion(items)
                    return
                }
            }
               let result = response.result.value as! [String: AnyObject]
                if let errorMessage = result["message"] as? String {
                    onError(errorMessage)
                    return
                } else {
                    onError("Error")
                    return
                }
            
        
        }
    }
    
}
