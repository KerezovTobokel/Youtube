//
//  ViewController.swift
//  YouTube
//
//  Created by Tobi on 2/5/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchBarVideo: UISearchBar!
    @IBOutlet weak var searchVideoTableView: UITableView!
    
    var videoVM = VideoViewModel()
    var items = [Item]()
    var textEncode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBar()
        self.setupTableViewCell()
    }
    
    
    func getVideo(text: String) {
        self.videoVM.getVideos(text: text, onCompletion: { (items) in
            self.items = items
            DispatchQueue.main.async {
                self.searchVideoTableView.reloadData()
            }
        }) { (error) in
            print(error!)
        }
    }
    
    func getNextVideo(text: String) {
        self.videoVM.getNextVideos(text: text, onCompletion: { (items) in
            self.items = items
        }) { (error) in
            print(error!)
        }
    }
    
    func setupTableViewCell() {
        self.searchVideoTableView.register(VideoTableViewCell.nib, forCellReuseIdentifier: VideoTableViewCell.identifier)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBarVideo.delegate = self
    }
    
    // Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as! VideoTableViewCell
        cell.item = items[indexPath.row]
        cell.setupCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard.init(name: Constants.MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "PlayVideoTableViewController") as! PlayVideoTableViewController
        vc.item = items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.items.count - 1 {
            if items.count < Constants.TOTAL_LIMIT {
                if let encode = self.textEncode {
                    self.getNextVideo(text: encode)
                }
                self.searchVideoTableView.reloadData()
            }
        }
    }
    
    // Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        let text = searchText.replacingOccurrences(of: " ", with: "")
        let encode = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics
            .union(CharacterSet.urlPathAllowed)
            .union(CharacterSet.urlHostAllowed))
        self.textEncode = encode
        self.getVideo(text: encode!)
        self.searchVideoTableView.reloadData()
    }
}

