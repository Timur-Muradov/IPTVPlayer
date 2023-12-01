//
//  Channel.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

struct Channel: Decodable {
    let identifier: Int
    let epgIdentifier: Int?
    let nameRus: String?
    let nameEng: String?
    let vitrinaEventsURL: String?
    let isFederal: Bool?
    let address: String
    let image: String
    let hasEpg: Bool
    let current: TVShow
    let regionCode: Int?
    let timeZone: Int
    let isForeign: Bool?
    let number: Int
    let drmStatus: Int?
    let owner: String
    let foreignPlayer: ForeignPlayer?
    let foreignPlayerKey: Bool?
    let url: String
    let urlSound: String?
    let cdn: String
    let urlArchive: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case epgIdentifier = "epg_id"
        case nameRus = "name_ru"
        case nameEng = "name_en"
        case vitrinaEventsURL = "vitrina_events_url"
        case isFederal = "is_federal"
        case address
        case image
        case hasEpg
        case current
        case regionCode = "region_code"
        case timeZone = "tz"
        case isForeign = "is_foreign"
        case number
        case drmStatus = "drm_status"
        case owner
        case foreignPlayer = "foreign_player"
        case foreignPlayerKey = "foreign_player_key"
        case url
        case urlSound = "url_sound"
        case cdn
        case urlArchive = "url_archive"
    }
}
