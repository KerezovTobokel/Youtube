//
//  Item.swift
//  YouTube
//
//  Created by Tobi on 2/6/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit

class Item: NSObject {
    var kind: String = ""
    var etag: String = ""
    var id: VideoId?
    var snippet: Snippet?
}
