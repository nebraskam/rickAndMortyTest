//
//  HomeViewModel.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 16-07-22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    @MainActor func loadCharacters()
    @MainActor func loadMoreCharacters()
    
    func navigateToCharacter(index: Int)
    
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private let repository: CharacterRepositoryProtocol
    private let router: AppRouterProtocol
    weak var view: HomeViewProtocol?
    
    private var characters: [CharacterModel] = []
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
                characters.append(contentsOf: response.results)
                let charactersPreview = characters.map { CharacterRepresentationPreviewModel(name: $0.name, imageUrl: $0.image) }
                view?.loadCharacters(charactersPreview)
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
    
    func navigateToCharacter(index: Int) {
        let character = characters[index]
        router.navigateTo(.detail(character))
    }
}
