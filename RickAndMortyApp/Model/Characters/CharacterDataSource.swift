//
//  CharacterDataSource.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation

protocol CharacterDataSourceProtocol: AnyObject {
    func getCharacters(in page: Int) async throws -> CharacterResponse
}

final class CharacterDataSource: CharacterDataSourceProtocol {
    
    private let requestManager: RequestManagerProtocol
    private let path = EndpointPath.character
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
    func getCharacters(in page: Int) async throws -> CharacterResponse {
        let finalPath = "\(path)?page=\(page)"
        let request = BaseRequest(path: finalPath)
        return try await requestManager.makeRequest(request)
    }
}

