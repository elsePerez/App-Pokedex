//
//  HomeRouter.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//

import UIKit

protocol HomeRoutering: AnyObject {
    func routerToSortFilter(sortFilterType: SortFilter, delegate: SortViewDelegate)
}

final class HomeRouter {
    weak var viewController: UIViewController?
}

// MARK: - HomeRoutering
extension HomeRouter: HomeRoutering {
    func routerToSortFilter(sortFilterType: SortFilter, delegate: SortViewDelegate) {
        let filter = SortViewController(filterSelected: sortFilterType)
        filter.delegate = delegate
        let nav = UINavigationController(rootViewController: filter)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        viewController?.present(nav, animated: true, completion: nil)
    }
}
