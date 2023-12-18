//
//  ChannelViewModel.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

struct ChannelViewModel: StreamData, Codable, Equatable {
    let id: Int
    let logo: URL?
    let title: String
    let currentShow: String
    let defaultItem: StreamModel
    var availableItems: [StreamModel]
    var isFavorite: Bool
    
    init?(from channel: Channel) {
        //let urlString = channel.url
        let urlString = "http://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8"
        guard let url = URL(string: urlString) else { return nil }
        self.id = channel.id
        self.logo = URL(string: channel.image) ?? nil
        self.title = channel.nameRu
        self.currentShow = channel.current.title
        self.defaultItem = StreamModel(URL: url, bandwith: 0, resolution: .auto)
        self.availableItems = M3U8Parser.availableItems(url)
        self.isFavorite = false
    }
}
