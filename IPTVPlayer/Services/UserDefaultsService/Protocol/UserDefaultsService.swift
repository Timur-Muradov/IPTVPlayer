//
//  UserDefaultsService.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

protocol UserDefaultsService {
    associatedtype D
    var savedData: D { get }
}
