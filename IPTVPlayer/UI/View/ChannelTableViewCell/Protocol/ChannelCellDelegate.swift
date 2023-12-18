//
//  ChannelCellDelegate.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 03.12.2023.
//

import Foundation

/// Channel table view cell delegate interface
protocol ChannelCellDelegate: AnyObject {
    func toggleFavorite(_ channel: ChannelViewModel)
}
