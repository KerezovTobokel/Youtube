//
//  ViewController.swift
//  YouTube
//
//  Created by Tobi on 2/5/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchBarVideo: UISearchBar!
    @IBOutlet weak var searchVideoTableView: UITableView!
    
    var videoVM = VideoViewModel()
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableViewCell()
        self.setupSearchBar()
        searchBarVideo.enablesReturnKeyAutomatically = true
    }
    
    func setupTableViewCell() {
        self.searchVideoTableView.register(VideoTableViewCell.nib, forCellReuseIdentifier: VideoTableViewCell.identifier)
    }
    
    func goWithText(text: String) {
        self.videoVM.getListOfItems(searchText: text
            , onCompletion: { (items) in
                self.items = items
                self.searchVideoTableView.reloadData()
        }) { (error) in
            print(error!)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBarVideo.delegate = self
    }
    
    
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
    
    // Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            return
        }
            let text = searchText.replacingOccurrences(of: " ", with: "")
            self.goWithText(text: text)
    }
}

