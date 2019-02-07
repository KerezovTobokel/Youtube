//
//  Thumbnail.swift
//  YouTube
//
//  Created by Tobi on 2/6/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import ObjectMapper

class Thumbnail: NSObject, Mappable {
    var higher: High?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        higher <- map["high"]
    }
}
