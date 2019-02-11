//
//  PlayVideoTableViewController.swift
//  YouTube
//
//  Created by Tobi on 2/7/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import WebKit

class PlayVideoTableViewController: BaseTableViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var videoWeb: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var chanelTitleLabel: UILabel!
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    let videoVM = VideoViewModel()
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = item?.snippet?.title
        self.tableView.tableFooterView = UIView(frame: .zero)
        if let item = self.item {
            if let videoId = item.id?.videoId {
                self.getVideo(videoCode: videoId)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getaInformation()
    }
    
    func getaInformation() {
        if let item = item, let snippet = item.snippet {
            self.titleLabel.text = snippet.title
            self.videoDescriptionLabel.text = snippet.videoDescription
            self.chanelTitleLabel.text = snippet.channelTitle
            let date = self.getDate()
            self.dateLabel.text = date.toDate_dMMMMyyyyString()
            if let url = snippet.thumbnails?.higher?.url {
                self.getPhotos(photoCode: url)
            }
        }
    }
    
    func getDate() -> Date {
        if let item = item, let snippet = item.snippet {
            if let date = Date.Date.iso8601.date(from: snippet.published) {
                return date
            } else {
                return Date()
            }
        } else {
            return Date()
        }
    }
    
    
    func getPhotos(photoCode: String) {
        self.videoVM.getPhoto(photoCode: photoCode, onCompletion: { (images) in
            self.videoImageView.image = images
            self.videoImageView.layer.cornerRadius = (self.videoImageView.frame.width / 2)
            self.videoImageView.layer.masksToBounds = true
        }) { (error) in
            print(error!)
        }
    }
    
    func getVideo(videoCode: String) {
        if let APIaddress = URL(string:  "https://www.youtube.com/embed/\(videoCode)") {
            self.videoWeb.load(URLRequest(url: APIaddress))
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        } else if indexPath.row == 3 {
            return 200
        } else {
            return UITableView.automaticDimension
        }
    }
}
