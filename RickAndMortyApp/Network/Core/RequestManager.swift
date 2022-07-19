//
//  BaseService.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation

protocol RequestManagerProtocol: AnyObject {
    func makeRequest<T: Decodable>(_ request: BaseRequest) async throws -> T
}

enum BaseServiceError: Error {
    case invalidURL
}

final class RequestManager: RequestManagerProtocol {
    
    private let apiConfig: ApiConfig
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    init(apiConfig: ApiConfig) {
        self.apiConfig = apiConfig
    }
    
    func makeRequest<T: Decodable>(_ request: BaseRequest) async throws -> T {
        let urlString = "\(apiConfig.baseURL)/\(request.path)"
        guard let url = URL(string: urlString) else {
            throw BaseServiceError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await session.data(for: urlRequest)
        let response = try decoder.decode(T.self, from: data)
        return response
    }    
}
