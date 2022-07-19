//
//  SceneDelegate.swift
//  RickAndMortyApp
//
//  Created by Nebraska Melendez on 16-07-22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appRotuer: AppRouterProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        appRotuer = AppRouter(window: window)
        appRotuer?.start()
    }
}

