//
//  Snippet.swift
//  YouTube
//
//  Created by Tobi on 2/6/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import ObjectMapper

class Snippet: NSObject, Mappable {
    
    var channelTitle: String = ""
    var title: String = ""
    var videoDescription: String = ""
    var thumbnails: Thumbnail?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        channelTitle <- map["channelTitle"]
        thumbnails <- map["thumbnails"]
        videoDescription <- map["description"]
        title <- map["title"]
    }
}
