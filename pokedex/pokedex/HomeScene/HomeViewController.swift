//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Matheus Perez on 24/03/22.
//

import UIKit
import AssetsLibrary

final class HomeViewController: UIViewController {
    
    func setupNavBar() {
        let width = self.view.frame.width
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: self.view.safeAreaInsets.top, width: width, height: 44))
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        self.view.addSubview(navigationBar)
        let generationButton = UIBarButtonItem(image: UIImage(named: "generationIcon"), style: .plain, target: self, action: #selector(generationButtonTapped))
        generationButton.tintColor = Colors.black
        let sortButton = UIBarButtonItem(image: UIImage(named: "sortIcon"), style: .plain, target: self, action: #selector(sortButtonTapped))
        sortButton.tintColor = Colors.black
        let filterButton = UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .plain, target: self, action: #selector(filterButtonTapped))
        filterButton.tintColor = Colors.black
        navigationItem.rightBarButtonItems = [filterButton, sortButton, generationButton]
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        setupNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
        
    }
    
    func setupHierarchy() {
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.backgroundColor
    }
}

private extension HomeViewController {
    @objc func filterButtonTapped() {
        view.backgroundColor = .red
    }
    
    @objc func generationButtonTapped() {
        view.backgroundColor = .blue
    }
    
    @objc func sortButtonTapped() {
        view.backgroundColor = .yellow
    }
}
