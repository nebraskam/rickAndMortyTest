//
//  CharacterModel+Mock.swift
//  RickAndMortyAppTests
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation
@testable import RickAndMortyApp

extension CharacterModel {
    
    static var characterMock = CharacterModel(
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

}
