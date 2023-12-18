//
//  NetworkService.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

enum ServiceMethod: String {
    case get = "GET"
}

/// Network service interface
protocol NetworkService {
    var baseURL: String { get }
    var path: String { get }
    var method: ServiceMethod { get }
}

extension NetworkService {
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }

    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        return urlComponents?.url
    }
}
