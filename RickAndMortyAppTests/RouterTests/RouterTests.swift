//
//  RouterTests.swift
//  RickAndMortyAppTests
//
//  Created by Nebraska Melendez on 19-07-22.
//

import XCTest
@testable import RickAndMortyApp

class RouterTests: XCTestCase {
    
    func test_has_set_rootViewController_when_start_method_is_called() throws {
        let window = UIWindow(frame: .zero)
        let sut = AppRouter(window: window)
        
        sut.start()
        
        XCTAssertNotNil(window.rootViewController)

        guard let navigationController = window.rootViewController as? UINavigationController,
              let topController = navigationController.viewControllers.last else {
            XCTFail()
            return
        }
        let topIsAHomeController = topController is HomeViewController
        XCTAssertTrue(topIsAHomeController)
    }
}

