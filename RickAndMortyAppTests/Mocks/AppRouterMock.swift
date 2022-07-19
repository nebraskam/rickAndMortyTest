//
//  AppRouterMock.swift
//  RickAndMortyAppTests
//
//  Created by Nebraska Melendez on 19-07-22.
//

import Foundation
@testable import RickAndMortyApp

final class AppRouterMock: AppRouterProtocol {

    var navigateIsCalled = false
    
    func start() {
    }
    
    func navigateTo(_ route: AppRoute) {
        navigateIsCalled = true
    }
}
