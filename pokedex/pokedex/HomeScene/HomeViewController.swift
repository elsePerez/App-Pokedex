//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Matheus Perez on 24/03/22.
//

import Lottie
import UIKit
import SnapKit

protocol HomeViewControllerDisplaying: AnyObject {
    func displayList()
    func startLoading()
    func stopLoading()
    func displayEmptyState()
}

final class HomeViewController: UIViewController {
    private lazy var generationButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Images.generationIcon.image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(generationButtonTapped))
        button.tintColor = Colors.black.color
        return button
    }   ()
    
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Images.sortIcon.image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(sortButtonTapped))
        button.tintColor = Colors.black.color
        return button
    }()
    
    private lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Images.filterIcon.image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(filterButtonTapped))
        button.tintColor = Colors.black.color
        return button
    }()
    
    func setupNavBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.isTranslucent = true
        
        navigationItem.rightBarButtonItems = [filterButton, sortButton, generationButton]
    }
    
    private lazy var pokeballImage = UIImageView(image: Images.cutPokeballBackground.image)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.primaryTitle
        label.textColor = Colors.black.color
        label.text = "Pokédex"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.primarySubtitle
        label.textColor = Colors.textGray.color
        label.text = "Search for Pokémon by name or using the National Pokédex number."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var searchBar: UISearchTextField = {
        let searchBar = UISearchTextField()
        searchBar.backgroundColor = .clear
        searchBar.keyboardType = .webSearch
        searchBar.autocorrectionType = .no
        searchBar.textColor = Colors.textGray.color
        searchBar.tintColor = Colors.textGray.color
        searchBar.font = Typography.primarySubtitle
        searchBar.delegate = self
        searchBar.placeholder = "What Pokémon are you looking for?"
        return searchBar
    }()
    
    private lazy var pokemonsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(PokemonListCell.self, forCellReuseIdentifier: PokemonListCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var summaryTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var animationView: AnimationView = {
        var animation = AnimationView()
        animation = .init(name: "pokeballLoading")
        animation.loopMode = .loop
        animation.animationSpeed = 1.2
        return animation
    }()
    
    private var emptyStateImage = UIImageView(image: Images.searchEmpty.image)
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.primaryTitle
        label.textColor = Colors.textGray.color
        label.text = "We didn't find your pokemon :("
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emptyStateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emptyStateImage, emptyStateLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isHidden = true
        return stackView
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isHidden = true
        return blurView
    }()
    
    override func viewWillLayoutSubviews() {
        setupNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
        interactor.fetchData()
        buildView()
    }
    
    private let interactor: HomeInteracting
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
        pokeballImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        summaryTitleStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top + 100)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(summaryTitleStackView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
            $0.height.equalTo(60)
        }
        
        pokemonsTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
        }
        
        animationView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(140)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(140)
            $0.height.equalTo(140)
        }
        
        emptyStateImage.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        
        emptyStateStackView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
        }
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupHierarchy() {
        view.addSubview(pokeballImage)
        view.addSubview(summaryTitleStackView)
        view.addSubview(searchBar)
        view.addSubview(pokemonsTableView)
        view.addSubview(animationView)
        view.addSubview(emptyStateStackView)
        view.addSubview(blurView)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.backgroundWhite.color
    }
}

// MARK: - Actions
private extension HomeViewController {
    @objc func filterButtonTapped() {
        view.backgroundColor = .red
    }
    
    @objc func generationButtonTapped() {
        view.backgroundColor = .blue
    }
    
    @objc func sortButtonTapped() {
        UIView.transition(with: self.view, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.blurView.isHidden = false
            self.interactor.showFilter(delegate: self)
        }, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UISearchTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fieldText = (textField.text ?? "") as NSString
        let newText = fieldText.replacingCharacters(in: range, with: string)
        interactor.searchPokemons(pokemonName: newText.lowercased())
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        interactor.searchPokemons(pokemonName: "")
        view.endEditing(true)
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICOU \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height / 2)
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.4,
            delay: 0.01 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.identifier, for: indexPath)
        guard let pokemonCell = cell as? PokemonListCell,
              let content = interactor.getContentCell(index: indexPath) else { return UITableViewCell()}
        pokemonCell.setup(pokemon: content)
        pokemonCell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - HomeViewControllerDisplaying
extension HomeViewController: HomeViewControllerDisplaying {
    func displayList() {
        emptyStateStackView.isHidden = true
        pokemonsTableView.reloadData()
        pokemonsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        stopLoading()
        pokemonsTableView.isHidden = false
    }
    
    func startLoading() {
        animationView.isHidden = false
        pokemonsTableView.isHidden = true
        emptyStateStackView.isHidden = true
        animationView.play()
    }
    
    func stopLoading() {
        animationView.isHidden = true
        animationView.stop()
    }
    
    func displayEmptyState() {
        emptyStateStackView.isHidden = false
        pokemonsTableView.isHidden = true
    }
}

extension HomeViewController: SortViewDelegate {
    func didClickFilter(sortType: SortFilter) {
        UIView.transition(with: self.view, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.blurView.isHidden = true
        }, completion: nil)
        
        interactor.getSortFilter(sortFilterType: sortType)
    }
}
