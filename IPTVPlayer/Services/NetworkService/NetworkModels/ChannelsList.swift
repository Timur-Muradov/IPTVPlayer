//
//  ChannelsList.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

/// Top level channels API model
struct ChannelsList: Decodable {
    let channels: [Channel]
}
