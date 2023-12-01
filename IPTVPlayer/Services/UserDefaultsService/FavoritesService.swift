//
//  FavoritesService.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

final class FavoritesService: UserDefaultsService {
    let userDefaults = UserDefaults.standard
    let key = "favorites"
    private(set) var savedData: [ChannelViewModel]
    
    init() {
        savedData = []
        load()
    }
    
    func addFavorite(_ channel: ChannelViewModel) {
        savedData.append(channel)
        save()
    }
    
    func removeFavorite(_ channel: ChannelViewModel) {
        if let index = savedData.firstIndex(of: channel) {
            savedData.remove(at: index)
            save()
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(savedData) {
            userDefaults.set(encoded, forKey: key)
        }
    }
    
    private func load() {
        if let data = userDefaults.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode([ChannelViewModel].self, from: data) {
                savedData = decoded
                return
            }
        }
    }
}
