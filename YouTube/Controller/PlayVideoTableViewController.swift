//
//  PlayVideoTableViewController.swift
//  YouTube
//
//  Created by Tobi on 2/7/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import AVFoundation
import YouTubePlayer
import SDWebImage

class PlayVideoTableViewController: BaseTableViewController {
    
    
    @IBOutlet weak var youTubePlay: YouTubePlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var chanelTitleLabel: UILabel!
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    var item: Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = item?.snippet?.title
        self.tableView.tableFooterView = UIView(frame: .zero)
        if let item = self.item {
            if let videoId = item.id?.videoId {
                getVideo(videoCode: videoId)
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
            if let url = snippet.thumbnails?.higher?.url {
                self.videoImageView.sd_setImage(with: URL(string: url), completed: nil)
            }
        }
    }
    
    func getVideo(videoCode: String) {
        
        if let APIaddress = URL(string:  "https://www.youtube.com/watch?v=\(videoCode)" ) {
            self.youTubePlay.loadVideoURL(APIaddress)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
             return 250
        } else {
             return UITableView.automaticDimension
        }
        
    }
}
