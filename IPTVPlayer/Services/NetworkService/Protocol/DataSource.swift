//
//  DataSource.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 02.12.2023.
//

import Foundation

protocol DataSource {
    var channels: [ChannelViewModel] { get }
    var favoriteChannels: [ChannelViewModel] { get }
    func fetchChannelsList(_ completion: @escaping () -> Void)
    func toggleFavorite(_ channels: [ChannelViewModel])
}
