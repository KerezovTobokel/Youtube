//
//  VideoId.swift
//  YouTube
//
//  Created by Tobi on 2/6/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import ObjectMapper

class VideoId: NSObject, Mappable {
    var kind: String = ""
    var videoId: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        videoId <- map["videoId"]
    }
}
