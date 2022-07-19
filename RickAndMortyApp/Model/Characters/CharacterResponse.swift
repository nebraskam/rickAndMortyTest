//
//  CharacterResponse.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation

struct CharacterResponse: Decodable {
    let results: [CharacterModel]
}
