//
//  Channel.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

/// Channel API model
struct Channel: Decodable {
    let id: Int
    let epgId: Int
    let nameRu: String
    let nameEn: String
    let vitrinaEventsUrl: String
    let isFederal: Bool
    let address: String
    let image: String
    let hasEpg: Bool
    let current: TVShow
    let regionCode: Int
    let tz: Int
    let isForeign: Bool
    let number: Int
    let drmStatus: Int
    let owner: String
    let foreignPlayer: ForeignPlayer
    let foreignPlayerKey: Bool
    let url: String
    let urlSound: String
    let cdn: String
    let urlArchive: String
}
