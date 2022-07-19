//
//  HomeViewMock.swift
//  RickAndMortyAppTests
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation
@testable import RickAndMortyApp

final class HomeViewMock: HomeViewProtocol {
    
    var startLoadingIsCalled = false
    var stopLoadingIsCalled = false
    var loadCharacterIsCalled = false
    
    func startLoading() {
        startLoadingIsCalled = true
    }
    
    func stopLoading() {
        stopLoadingIsCalled = true
    }
    
    func loadCharacters(_ characters: [CharacterRepresentationPreviewModel]) {
        loadCharacterIsCalled = true
    }
    
    func showDefaultError() {
        
    }
}
