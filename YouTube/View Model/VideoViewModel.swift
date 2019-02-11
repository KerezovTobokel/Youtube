//
//  VideoViewModel.swift
//  YouTube
//
//  Created by Tobi on 2/6/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
let API_KEY  = "AIzaSyCsitt_aLjCFlEAv5UGpcAalplTVJy45Xk"
//let API_KEY  = "AIzaSyC87Jgo4z0wMRj-m8AKVynnZuwd1vFXBVU"
let Youtube_URL = "https://www.googleapis.com/youtube/v3/search?part=snippet"

class VideoViewModel: NSObject {
    
    var items = [Item]()
    let imageCache = NSCache<AnyObject, AnyObject>()
    private var currentUrl: String?
    var imageVideo = UIImage()
    
    override init(){
        super.init()
    }
    //https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=&type=video&key=AIzaSyCsitt_aLjCFlEAv5UGpcAalplTVJy45Xk
    
    func getVideos(text: String, onCompletion: @escaping (([Item]) -> Void), onError: @escaping ((String?) -> Void)) {
        if let url = URL(string: "\(Youtube_URL)&maxResults=20&order=Relevance&q=\(text)&type=video&key=\(API_KEY)") {
            URLSession.shared.dataTask(with:  url) { (data, responce, error) in
                if error == nil {
                    if let dataObject = data {
                        do {
                            let json: [String: Any] = try JSONSerialization.jsonObject(with: dataObject, options: .mutableContainers) as! [String : Any]
                            if let itemsDict = json["items"] as? [[String: Any]] {
                                self.items.removeAll()
                                for itemAny in itemsDict {
                                    let item = Item()
                                    item.etag = itemAny["etag"] as! String
                                    item.kind = itemAny["kind"] as! String
                                    
                                    let itemId = itemAny["id"] as! [String: Any]
                                    item.id = VideoId()
                                    item.id!.kind = itemId["kind"] as! String
                                    item.id!.videoId = itemId["videoId"] as! String
                                    
                                    let snippetId = itemAny["snippet"] as! [String: Any]
                                    item.snippet = Snippet()
                                    item.snippet?.channelTitle = snippetId["channelTitle"] as! String
                                    item.snippet?.title = snippetId["title"] as! String
                                    item.snippet?.published = snippetId["publishedAt"] as! String
                                    item.snippet?.videoDescription = snippetId["description"] as! String
                                    item.snippet?.thumbnails = Thumbnail()
                                    
                                    let thumbnailsId =  snippetId["thumbnails"] as! [String: Any]
                                    item.snippet?.thumbnails?.higher = High()
                                    
                                    let highVideo = thumbnailsId["high"] as! [String: Any]
                                    item.snippet?.thumbnails?.higher!.url = highVideo["url"] as! String
                                    self.items.append(item)
                                    onCompletion(self.items)
                                }
                            }
                        } catch let parsingError {
                            print("Error", parsingError)
                        }
                    }
                }
                }.resume()
        }
    }
    
    func getNextVideos(text: String, onCompletion: @escaping (([Item]) -> Void), onError: @escaping ((String?) -> Void)) {
        if let url = URL(string: "\(Youtube_URL)&maxResults=20&order=Relevance&q=\(text)&type=video&key=\(API_KEY)") {
            URLSession.shared.dataTask(with:  url) { (data, responce, error) in
                if error == nil {
                    if let dataObject = data {
                        do {
                            let json: [String: Any] = try JSONSerialization.jsonObject(with: dataObject, options: .mutableContainers) as! [String : Any]
                            if let itemsDict = json["items"] as? [[String: Any]] {
                                for itemAny in itemsDict {
                                    let item = Item()
                                    item.etag = itemAny["etag"] as! String
                                    item.kind = itemAny["kind"] as! String
                                    
                                    let itemId = itemAny["id"] as! [String: Any]
                                    item.id = VideoId()
                                    item.id!.kind = itemId["kind"] as! String
                                    item.id!.videoId = itemId["videoId"] as! String
                                    
                                    let snippetId = itemAny["snippet"] as! [String: Any]
                                    item.snippet = Snippet()
                                    item.snippet?.channelTitle = snippetId["channelTitle"] as! String
                                    item.snippet?.title = snippetId["title"] as! String
                                    item.snippet?.published = snippetId["publishedAt"] as! String
                                    item.snippet?.videoDescription = snippetId["description"] as! String
                                    item.snippet?.thumbnails = Thumbnail()
                                    
                                    let thumbnailsId =  snippetId["thumbnails"] as! [String: Any]
                                    item.snippet?.thumbnails?.higher = High()
                                    
                                    let highVideo = thumbnailsId["high"] as! [String: Any]
                                    item.snippet?.thumbnails?.higher!.url = highVideo["url"] as! String
                                    self.items.append(item)
                                    onCompletion(self.items)
                                }
                            }
                        } catch let parsingError {
                            print("Error", parsingError)
                        }
                    }
                }
                }.resume()
        }
    }
    
    func getPhoto(photoCode: String, onCompletion: @escaping ((UIImage) -> Void), onError: @escaping ((String?) -> Void)) {
        let urlString = photoCode
        currentUrl = urlString
        
        if (imageCache.object(forKey: urlString as AnyObject) != nil) {
            self.imageVideo = imageCache.object(forKey: urlString as AnyObject) as! UIImage
            onCompletion(self.imageVideo)
        } else {
            if let url = URL(string: currentUrl!) {
                URLSession.shared.dataTask(with: url) { (data, responce, error) in
                    if error == nil {
                        if let dataObject = data {
                            if let downloadedImage = UIImage(data: dataObject) {
                                if (urlString == self.currentUrl) {
                                    self.imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                                    self.imageVideo = downloadedImage
                                    DispatchQueue.main.async {
                                        onCompletion(downloadedImage)
                                    }
                                }
                            }
                        }
                    }
                    }.resume()
            }
        }
    }
}
