//
//  Item.swift
//  YouTube
//
//  Created by Tobi on 2/6/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import ObjectMapper

class Item: NSObject, Mappable {
    var kind: String = ""
    var etag: String = ""
    var id: VideoId?
    var snippet: Snippet?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        etag <- map["etag"]
        id <- map["id"]
        snippet <- map["snippet"]
    }
    
}
