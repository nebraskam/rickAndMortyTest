//
//  HomeViewModel.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 16-07-22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var charactersPreview: [CharacterRepresentationPreviewModel] { get }
    @MainActor func loadCharacters()
    @MainActor func loadMoreCharacters()
    func navigateToCharacter(index: Int)
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private let repository: CharacterRepositoryProtocol
    private let router: AppRouterProtocol
    weak var view: HomeViewProtocol?
    
    private var characters: [CharacterModel] = []
    var charactersPreview: [CharacterRepresentationPreviewModel] = []

    private var currentPage: Int = 1
    
    init(repostory: CharacterRepositoryProtocol, router: AppRouterProtocol) {
        self.repository = repostory
        self.router = router
    }
    
    func loadCharacters() {
        Task {
            view?.startLoading()
            do {
                let response = try await repository.getCharacters(in: currentPage)
                updateCharacters(with: response)
                view?.loadCharacters()
            } catch {
                view?.showDefaultError()
            }
            view?.stopLoading()
        }
    }
    
    func loadMoreCharacters() {
        currentPage += 1
        loadCharacters()
    }
    
    private func updateCharacters(with response: CharacterResponse) {
        let newCharacters = response.results
        let newCharacterPreviews = newCharacters.map { CharacterRepresentationPreviewModel(name: $0.name, imageUrl: $0.image) }
        characters.append(contentsOf: newCharacters)
        charactersPreview.append(contentsOf: newCharacterPreviews)
    }
    
    func navigateToCharacter(index: Int) {
        guard let character = characters[safe: index] else { return }
        router.navigateTo(.detail(character))
    }
}
