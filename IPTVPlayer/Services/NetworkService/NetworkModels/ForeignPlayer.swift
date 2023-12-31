//
//  ForeignPlayer.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

/// Foreign player API model
struct ForeignPlayer: Decodable {
    let sdk: String
    let url: String
    let validFrom: Int
}
