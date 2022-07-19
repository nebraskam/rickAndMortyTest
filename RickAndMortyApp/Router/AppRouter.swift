//
//  AppRouter.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation
import UIKit

protocol AppRouterProtocol: AnyObject {
    func start()
    func navigateTo(_ route: AppRoute)
}

final class AppRouter: AppRouterProtocol {
    
    weak var window: UIWindow?
    private var rootViewController: UINavigationController?
    private let requestManager: RequestManager = {
        return RequestManager(apiConfig: ApiConfig())
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let viewController = getViewControllerFor(.home)
        rootViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func navigateTo(_ route: AppRoute) {
        let controller = getViewControllerFor(route)
        rootViewController?.pushViewController(controller, animated: true)
    }
    
    private func getViewControllerFor(_ route: AppRoute) -> UIViewController {
        switch route {
        case .home:
            return makeHomeViewController()
        case .detail(let model):
            return makeDetailViewController(model: model)
        }
    }
    
    private func makeHomeViewController() -> UIViewController {
        let dataSource = CharacterDataSource(requestManager: requestManager)
        let repository = CharacterRepository(dataSource: dataSource)
        let viewModel = HomeViewModel(repostory: repository, router: self)
        let homeViewController = HomeViewController(viewModel: viewModel)
        viewModel.view = homeViewController
        return homeViewController
    }
    
    private func makeDetailViewController(model: CharacterModel) -> UIViewController {
        let representationModel = CharacterRepresentationModel(
            name: model.name,
            imageUrl: model.image,
            gender: model.gender,
            species: model.species,
            status: model.status,
            lastLocation: model.location.name,
            originLocation: model.origin.name
        )
        return DetailViewController(model: representationModel)
    }    
}
