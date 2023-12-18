//
//  FavoriteChannelsService.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

enum PersistanceKeys: String {
    case favoriteChannels
}

/// User defaults persistance service
final class FavoriteChannelsService: PersistanceService {
    let userDefaults = UserDefaults.standard
    private(set) var dataToSave: [ChannelViewModel]
    
    init() {
        dataToSave = []
    }
    
    func save(data: [ChannelViewModel]) {
        if let encoded = try? JSONEncoder().encode(data) {
            userDefaults.set(encoded, forKey: PersistanceKeys.favoriteChannels.rawValue)
        }
    }
        
    func load() -> [ChannelViewModel] {
        if let data = userDefaults.data(forKey: PersistanceKeys.favoriteChannels.rawValue) {
            if let decoded = try? JSONDecoder().decode([ChannelViewModel].self, from: data) {
                return decoded
            }
        }
        return []
    }
}
