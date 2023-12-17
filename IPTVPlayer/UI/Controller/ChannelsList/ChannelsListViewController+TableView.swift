//
//  ChannelsListViewController+TableView.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 10.12.2023.
//

import UIKit



extension ChannelsListViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = PlayerViewController(nibName: "PlayerViewController", bundle: Bundle.main)
        player.channel = self.channels[indexPath.row]
        player.modalPresentationStyle = .fullScreen
        present(player, animated: true)
    }
}
