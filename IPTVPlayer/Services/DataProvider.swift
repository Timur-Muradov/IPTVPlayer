//
//  DataProvider.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

final class DataProvider: DataSource {
    private let network: NetworkServiceProvider<ChannelsNetworkService>
    private let favoriteService: FavoriteChannelsService
    var channels: [ChannelViewModel] = []
    var favoriteChannels: [ChannelViewModel] = []
    
    init(network: NetworkServiceProvider<ChannelsNetworkService>,
         favoriteService: FavoriteChannelsService) {
        self.network = network
        self.favoriteService = favoriteService
    }
    
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
                        channels.append(ChannelViewModel(from: channel))
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
    
    func toggleFavorite(_ channels: [ChannelViewModel]) {
        for channel in channels {
            if let index = self.channels.firstIndex(where: { $0.id == channel.id }) {
                self.channels[index].toggleFavorite()
            } else {
                debugPrint("\(channel.title) channel is unavailable")
            }
        }
        favoriteChannels = self.channels.filter { $0.isFavorite == true }
        favoriteService.save(data: favoriteChannels)
    }
}
