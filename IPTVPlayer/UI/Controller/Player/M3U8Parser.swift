//
//  M3U8Parser.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 17.12.2023.
//

import AVKit

/// This helper should download '.m3u8' file and parse it to stream model
/// Current API does not return '.m3u8' so i cannot be sure if  amount of
/// channel resolutions is static or dynamic. In case amount of channel
/// resolutions static i can use different variable for each resolution and
/// static UI, overwise model and UI should be dynamic.
final class M3U8Parser {
    // MARK: - Prevent to create instance.
    private init() {}
    
    /// Download and parse '.m3u8' file from URL
    /// - Parameter url: url to '.m3u8' file
    /// - Returns: for now it will return mock model
    static func availableItems(_ url: URL) -> [StreamModel] {
        // TODO: - Add implementation when API will be available
        return mockItems()
    }
}
// MARK: - Private interface
private extension M3U8Parser {
    /// Harcoded stream model for POC
    static func mockItems() -> [StreamModel] {
        var result: [StreamModel] = []
        if let p1080url: URL = URL(string: "http://sample.vodobox.net/skate_phantom_flex_4k/fullhd/skate_phantom_flex_4k_4160_1080p.m3u8") {
            let p1080 = StreamModel(URL: p1080url, bandwith: 5400000, resolution: .p1080)
            result.append(p1080)
        }
        if let p720url: URL = URL(string: "http://sample.vodobox.net/skate_phantom_flex_4k/hdready/skate_phantom_flex_4k_2112_720p.m3u8") {
            let p720 = StreamModel(URL: p720url, bandwith: 2742000, resolution: .p720)
            result.append(p720)
        }
        if let p480url: URL = URL(string: "http://sample.vodobox.net/skate_phantom_flex_4k/veryhigh/skate_phantom_flex_4k_1056_480p.m3u8") {
            let p480 = StreamModel(URL: p480url, bandwith: 1366000, resolution: .p480)
            result.append(p480)
        }
        if let p360url: URL = URL(string: "http://sample.vodobox.net/skate_phantom_flex_4k/high/skate_phantom_flex_4k_788_360p.m3u8") {
            let p360 = StreamModel(URL: p360url, bandwith: 1018000, resolution: .p360)
            result.append(p360)
        }
        return result
    }
}
