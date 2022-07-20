//
//  CharacterRepositoryMock.swift
//  RickAndMortyAppTests
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation
@testable import RickAndMortyApp

final class CharacterRepositoryMock: CharacterRepositoryProtocol {
    func getCharacters(in page: Int) async throws -> CharacterResponse {
        return .init(results: [.characterMock])
    }
}
