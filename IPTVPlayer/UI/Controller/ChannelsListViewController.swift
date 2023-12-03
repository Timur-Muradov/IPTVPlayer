//
//  ChannelsListViewController.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import UIKit

class ChannelsListViewController: UITableViewController {
    var dataSource: DataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ChannelTableViewCell", bundle: Bundle.main)
        self.tableView.register(cellNib, forCellReuseIdentifier: "ChannelTableViewCell")
        dataSource?.fetchChannelsList {
            self.configureUI()
        }
    }
    
    func configureUI() {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = dataSource?.channels.count ?? 0
        print(count)
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelTableViewCell", for: indexPath) as? ChannelTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = dataSource?.channels[indexPath.row].title
        return cell
    }
}

