//
//  DataSourceBuilder.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 02.12.2023.
//

import Foundation

/// Builder for data sourse services
final class DataSourceBuilder {
    // Prevent to create instance
    private init() {}
    /// Return configured data source 
    static func buildDataSource() -> DataSource {
        let network = NetworkServiceProvider<ChannelsNetworkService>()
        let favorite = FavoriteChannelsService()
        return DataProvider(network: network, favoriteService: favorite)
    }
}
