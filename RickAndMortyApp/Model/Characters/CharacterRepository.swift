//
//  CharacterRepository.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation

protocol CharacterRepositoryProtocol: AnyObject {
    func getCharacters(in page: Int) async throws -> CharacterResponse
}

final class CharacterRepository: CharacterRepositoryProtocol {
    
    private let dataSource: CharacterDataSourceProtocol
    
    init(dataSource: CharacterDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getCharacters(in page: Int) async throws -> CharacterResponse {
        return try await dataSource.getCharacters(in: page)
    }
}
