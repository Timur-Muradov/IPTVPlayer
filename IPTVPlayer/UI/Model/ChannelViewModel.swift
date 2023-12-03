//
//  ChannelViewModel.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

struct ChannelViewModel: StreamingData, Codable, Equatable {
    let id: Int
    let logo: URL?
    let title: String
    let currentShow: String
    let playlistURL: URL?
    var isFavorite: Bool
    
    mutating func toggleFavorite() {
        isFavorite = !isFavorite
    }
    
    init(from channel: Channel) {
        self.id = channel.id
        self.logo = URL(string: channel.image) ?? nil
        self.title = channel.nameRu
        self.currentShow = channel.current.title
        self.playlistURL = URL(string: channel.url) ?? nil
        self.isFavorite = false
    }
}
