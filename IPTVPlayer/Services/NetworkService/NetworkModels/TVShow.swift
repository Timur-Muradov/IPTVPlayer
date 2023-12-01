//
//  TVShow.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

struct TVShow: Decodable {
    let timestart: Int
    let timestop: Int
    let title: String
    let desc: String
    let cdnvideo: Int
    let rating: Int
}
