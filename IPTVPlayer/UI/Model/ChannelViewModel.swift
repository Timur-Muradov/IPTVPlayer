//
//  ChannelViewModel.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

struct ChannelViewModel: StreamingData, Codable, Equatable {
    let logo: URL
    let title: String
    let currentShow: String
    let playlistURL: URL
    let isFavorite: Bool
}
