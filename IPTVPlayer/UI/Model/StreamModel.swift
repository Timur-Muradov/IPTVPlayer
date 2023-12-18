//
//  StreamModel.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 17.12.2023.
//

import AVKit

/// View model with stream configuration
struct StreamModel: StreamItem, Codable, Equatable {
    var URL: URL
    var bandwith: Double
    var resolution: VideoResolution
    var item: AVPlayerItem {
        let asset = AVURLAsset(url: URL)
        let item = AVPlayerItem(asset: asset)
        item.preferredPeakBitRate = bandwith
        return item
    }
}
