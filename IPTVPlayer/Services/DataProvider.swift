//
//  DataProvider.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

/// Data provider that covers application business logic
final class DataProvider: DataSource {
    // MARK: - Private properties
    private let network: NetworkServiceProvider<ChannelsNetworkService>
    private let favoriteService: FavoriteChannelsService
    // MARK: - Properties
    var channels: [ChannelViewModel] = []
    var favoriteChannels: [ChannelViewModel] = []
    // MARK: - Initialization
    init(network: NetworkServiceProvider<ChannelsNetworkService>,
         favoriteService: FavoriteChannelsService) {
        self.network = network
        self.favoriteService = favoriteService
    }
    
    /// Return array of channel view models
    func fetchChannelsList(_ completion: @escaping () -> Void) {
        network.load(service: .channels) { result in
            switch result {
            case .success(let resp):
                debugPrint(resp)
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let response = try decoder.decode(ChannelsList.self, from: resp)
                    debugPrint(response)
                    var channels: [ChannelViewModel] = []
                    for channel in response.channels {
                        if let model = ChannelViewModel(from: channel) {
                            channels.append(model)
                        }
                    }
                    DispatchQueue.main.async {
                        self.channels = channels
                        self.toggleFavorite(self.favoriteService.load())
                        completion()
                    }
                } catch let jsonError {
                    debugPrint(jsonError)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .empty:
                debugPrint("No data")
            }
        }
    }
    
    /// Toggle channels favorite
    /// - Parameter channels: channels to toggle
    func toggleFavorite(_ channels: [ChannelViewModel]) {
        for channel in channels {
            if let index = self.channels.firstIndex(where: { $0.id == channel.id }) {
                self.channels[index].isFavorite = !self.channels[index].isFavorite
            } else {
                debugPrint("\(channel.title) channel is unavailable")
            }
        }
        favoriteChannels = self.channels.filter { $0.isFavorite == true }
        favoriteService.save(data: favoriteChannels)
    }
}
