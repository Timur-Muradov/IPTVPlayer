//
//  PersistanceService.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

/// Persistance service interface
protocol PersistanceService {
    associatedtype D
    func load() -> D
    func save(data: D)
}
