//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let created: String
    let image: String
    let origin: Location
    let location: Location
}

struct Location: Decodable {
    let name: String
}
