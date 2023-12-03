//
//  ChannelsListViewController.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import UIKit

enum ChannelsListFilter {
    case all, favorites, none
}

class ChannelsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChannelCellDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    var dataSource: DataSource?
    var filter: ChannelsListFilter = .none
    var channels: [ChannelViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ChannelTableViewCell", bundle: Bundle.main)
        self.tableView.register(cellNib, forCellReuseIdentifier: "ChannelTableViewCell")
        dataSource?.fetchChannelsList {
            self.channels = self.dataSource?.channels ?? []
            self.filter = .all
            self.configureUI()
        }
    }
    
    func configureUI() {
        switch filter {
        case .all:
            self.channels = self.dataSource?.channels ?? []
        case .favorites:
            self.channels = self.dataSource?.favoriteChannels ?? []
        default:
            self.channels = []
        }
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelTableViewCell", for: indexPath) as? ChannelTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.channel = channels[indexPath.row]
        return cell
    }
            
    func toggleFavorite(_ channel: ChannelViewModel) {
        dataSource?.toggleFavorite([channel])
        self.configureUI()
    }
    
    @IBAction func showAllChannels(_ sender: Any) {
        self.filter = .all
        self.configureUI()
    }
    
    @IBAction func showFavoriteChannels(_ sender: Any) {
        self.filter = .favorites
        self.configureUI()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let predicate = searchBar.text, !predicate.isEmpty {
            switch filter {
            case .all:
                self.channels = dataSource?.channels.filter({
                    $0.title.contains(predicate)
                }) ?? []
            case .favorites:
                self.channels = dataSource?.favoriteChannels.filter({
                    $0.title.contains(predicate)
                }) ?? []
            default:
                self.channels = []
            }
        } else {
            self.channels = dataSource?.channels ?? []
        }
        channels = dataSource?.channels.filter({
            $0.title.contains(searchBar.text ?? "")
        }) ?? []
        tableView.reloadData()
        return true
    }
}

