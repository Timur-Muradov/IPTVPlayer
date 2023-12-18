//
//  NetworkServiceProvider.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
    case empty
}

/// Network service provider
final class NetworkServiceProvider<T: NetworkService> {
    // MARK: - Properties
    var urlSession = URLSession.shared
    // MARK: - Initialization
    init() { }

    func load(service: T, completion: @escaping (Result<Data>) -> Void) {
        call(service.urlRequest, completion: completion)
    }

    func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U>) -> Void) where U: Decodable {
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let resp = try decoder.decode(decodeType, from: data)
                    completion(.success(resp))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            }
        }
    }
}
// MARK: - Private interface
extension NetworkServiceProvider {
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data>) -> Void) {
        urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            } else {
                deliverQueue.async {
                    completion(.empty)
                }
            }
            }.resume()
    }
}
