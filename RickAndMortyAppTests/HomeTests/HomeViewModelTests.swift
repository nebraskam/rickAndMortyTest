//
//  HomeViewModelTests.swift
//  RickAndMortyAppTests
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation

import XCTest
@testable import RickAndMortyApp

class HomeViewModelTests: XCTestCase {
    
    var viewMock = HomeViewMock()
    var routerMock = AppRouterMock()
    
    override func setUpWithError() throws {
        viewMock = HomeViewMock()
        routerMock = AppRouterMock()
    }

    func test_retrieve_characters_when_loadCharacters_isCalled() throws {
            let repositoryMock = CharacterRepositoryMock()
            let sut = HomeViewModel(repostory: repositoryMock, router: self.routerMock)
            sut.view = self.viewMock
            
            let expectation = self.expectation(description: "loadCharacters")
            
            Task {
                await sut.loadCharacters()
                try await Task.sleep(nanoseconds: 3_000_000_000)
                expectation.fulfill()
            }

            self.waitForExpectations(timeout: 5, handler: nil)
            XCTAssertTrue(self.viewMock.startLoadingIsCalled)
            XCTAssertTrue(self.viewMock.stopLoadingIsCalled)
            XCTAssertTrue(self.viewMock.loadCharacterIsCalled)
    }
    
    func test_navigation_when_character_isSelected() {
       
        let repositoryMock = CharacterRepositoryMock()
        let sut = HomeViewModel(repostory: repositoryMock, router: self.routerMock)
        sut.view = self.viewMock
        
        let expectation = self.expectation(description: "navigateTo")
        
        Task {
            await sut.loadCharacters()
            try await Task.sleep(nanoseconds: 3_000_000_000)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 5, handler: nil)
        
        sut.navigateToCharacter(index: 0)
        XCTAssertTrue(self.routerMock.navigateIsCalled)
    }
    
    func test_navigation_when_called_with_malformed_index() {
            let repositoryMock = CharacterRepositoryMock()
            let sut = HomeViewModel(repostory: repositoryMock, router: routerMock)
            sut.view = self.viewMock
            
            sut.navigateToCharacter(index: 1000)
            
            XCTAssertFalse(routerMock.navigateIsCalled)
    }

}
