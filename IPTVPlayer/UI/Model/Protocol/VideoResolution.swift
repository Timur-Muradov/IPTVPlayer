//
//  VideoResolution.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 17.12.2023.
//

import Foundation

/// Available video resolutions
enum VideoResolution: Int, Codable, Equatable {
    case auto = 0
    case p1080 = 1080
    case p720 = 720
    case p480 = 480
    case p360 = 360
}
