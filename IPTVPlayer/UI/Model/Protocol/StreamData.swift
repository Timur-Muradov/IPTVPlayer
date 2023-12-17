//
//  StreamData.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

protocol StreamData: Codable, Equatable {
    var logo: URL? { get }
    var title: String { get }
    var currentShow: String { get }
    var defaultItem: StreamModel { get }
    var availableItems: [StreamModel] { get }
    var isFavorite: Bool { get }
}
