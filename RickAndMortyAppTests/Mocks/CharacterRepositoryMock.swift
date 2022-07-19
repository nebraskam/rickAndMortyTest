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
        let characterMock = CharacterModel(
            id: 0,
            name: "Morty",
            status: "Alive",
            species: "Human",
            type: "-",
            gender: "-",
            created: "-",
            image: "",
            origin: .init(name: "earth"),
            location: .init(name: "earth")
        )
        return .init(results: [characterMock])
    }
}
