//
//  VideoTableViewCell.swift
//  YouTube
//
//  Created by Tobi on 2/5/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import SDWebImage

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var imageVideoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
 
    func setupCell(){
        if let item = item, let snippet = item.snippet {
            self.titleLabel.text = snippet.title
            self.descriptionLabel.text = snippet.videoDescription
            if let url = snippet.thumbnails?.higher?.url {
                self.imageVideoView.sd_setImage(with: URL(string: url), completed: nil)
            }
        }
    }
    
}
