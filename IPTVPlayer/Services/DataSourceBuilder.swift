//
//  DataSourceBuilder.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 02.12.2023.
//

import Foundation

final class DataSourceBuilder {
    private init() {}
    static func buildDataSource() -> DataSource {
        let network = NetworkServiceProvider<ChannelsNetworkService>()
        let favorite = FavoriteChannelsService()
        return DataProvider(network: network, favoriteService: favorite)
    }
}
