//
//  ChannelsNetworkService.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

/// Chanel network service
enum ChannelsNetworkService {
    case channels
}

extension ChannelsNetworkService: NetworkService {
    var baseURL: String {
        return "https://assets-iptv2022.cdnvideo.ru"
    }

    var path: String {
        switch self {
        case .channels:
            return "/uploads/asset_file/4019/response.json"
        }
    }

    var method: ServiceMethod {
        return .get
    }
}
