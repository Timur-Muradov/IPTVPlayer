//
//  StreamItem.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 17.12.2023.
//

import AVKit

protocol StreamItem: Codable, Equatable {
    var URL: URL { get }
    var bandwith: Double { get }
    var resolution: VideoResolution { get }
    var item: AVPlayerItem { get }
}
