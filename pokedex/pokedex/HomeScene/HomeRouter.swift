//
//  HomeRouter.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//

import UIKit

protocol HomeRoutering: AnyObject {
    func routerToTest()
}

final class HomeRouter {
    weak var viewController: UIViewController?
}

// MARK: - HomeRoutering
extension HomeRouter: HomeRoutering {
    func routerToTest() {
        
    }
}
