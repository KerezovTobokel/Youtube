//
//  VideoViewModel.swift
//  YouTube
//
//  Created by Tobi on 2/6/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit

class VideoViewModel: NSObject {

    override init(){
        super.init()
        
    }
    
    func getListOfItems(searchText: String, onCompletion: @escaping (([Item]) -> Void), onError: @escaping ((String?) -> Void)) {
        Service.instance.getListOfItems(searchText: searchText, onCompletion: { (items) in
            onCompletion(items)
        }) { (error) in
            onError(error!)
        }
    }
}
