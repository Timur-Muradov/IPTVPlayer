//
//  M3U8Parser.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 17.12.2023.
//

import AVKit

final class M3U8Parser {
    private init() {}
    
    static func availableItems(_ url: URL) -> [StreamModel] {
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

//case p1080 = 1080
//case p720 = 720
//case p480 = 480
//case p360 = 360
