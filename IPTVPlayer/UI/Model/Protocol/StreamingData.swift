//
//  StreamingData.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

protocol StreamingData {
    var logo: URL? { get }
    var title: String { get }
    var currentShow: String { get }
    var playlistURL: URL? { get }
    var isFavorite: Bool { get }
    
    mutating func toggleFavorite()
}
