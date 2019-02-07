//
//  High.swift
//  YouTube
//
//  Created by Tobi on 2/6/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import ObjectMapper

class High: NSObject, Mappable {
    var url: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url <- map["url"]
    }
}
