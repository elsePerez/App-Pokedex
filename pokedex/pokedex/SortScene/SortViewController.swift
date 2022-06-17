//
//  FilterView.swift
//  pokedex
//
//  Created by Matheus Perez on 16/06/22.
//

import Foundation
import UIKit

enum SortFilter {
    case sortSmallest
    case sortHighest
    case sortAZ
    case sortZA
}

protocol SortViewDelegate: AnyObject {
    func didClickFilter(sortType: SortFilter)
}

final class SortViewController: UIViewController {
    weak var delegate: SortViewDelegate?
    private var filterSelected: SortFilter
    private lazy var arrayButtons = [sortSmallestIdButton,
                                     sortHighestIdButton,
                                     sortAZButton,
                                     sortZAButton]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.secondaryTitle
        label.textColor = Colors.black.color
        label.text = "Sort"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.primarySubtitle
        label.textColor = Colors.textGray.color
        label.text = "Sort Pokémons alphabetically or by National Pokédex number!"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var summaryTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space0
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var sortSmallestIdButton: FilterButton = {
        let button = FilterButton(filterType: .sortSmallest)
        button.setTitle("Smallest number first", for: .normal)
        button.setTitleColor(Colors.textGray.color, for: .normal)
        button.backgroundColor = Colors.backgroundDefaultInput.color
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var sortHighestIdButton: FilterButton = {
        let button = FilterButton(filterType: .sortHighest)
        button.setTitle("Highest number first", for: .normal)
        button.setTitleColor(Colors.textGray.color, for: .normal)
        button.backgroundColor = Colors.backgroundDefaultInput.color
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var sortAZButton: FilterButton = {
        let button = FilterButton(filterType: .sortAZ)
        button.setTitle("A-Z", for: .normal)
        button.setTitleColor(Colors.textGray.color, for: .normal)
        button.backgroundColor = Colors.backgroundDefaultInput.color
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var sortZAButton: FilterButton = {
        let button = FilterButton(filterType: .sortZA)
        button.setTitle("Z-A", for: .normal)
        button.setTitleColor(Colors.textGray.color, for: .normal)
        button.backgroundColor = Colors.backgroundDefaultInput.color
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sortSmallestIdButton, sortHighestIdButton, sortAZButton, sortZAButton])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space4
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    init(filterSelected: SortFilter) {
        self.filterSelected = filterSelected
        super.init(nibName: nil, bundle: nil)
        switch filterSelected {
        case .sortSmallest:
            sortSmallestIdButton.isSelected = true
        case .sortHighest:
            sortHighestIdButton.isSelected = true
        case .sortAZ:
            sortAZButton.isSelected = true
        case .sortZA:
            sortZAButton.isSelected = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didClickFilter(sortType: filterSelected)
    }
}

// MARK: - Actions
private extension SortViewController {
    @objc func buttonTapped(_ button: UIButton) {
        toogleButton(button: button)
    }
}

extension SortViewController: ViewSetup {
    func setupConstraints() {
        summaryTitleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(summaryTitleStackView.snp.bottom)
                .offset(34)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        sortSmallestIdButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        sortHighestIdButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        sortAZButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        sortZAButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
    
    func setupHierarchy() {
        view.addSubview(summaryTitleStackView)
        view.addSubview(buttonStackView)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.white.color
    }
}

private extension SortViewController {
    func toogleButton(button: UIButton) {
        arrayButtons.forEach {
            $0.isSelected = false
        }
        
        button.isSelected.toggle()
        arrayButtons.forEach {
            if $0.isSelected == true {
                self.filterSelected = $0.filterType
            }
        }
    }
}

final class FilterButton: UIButton {
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected
            ? Colors.psychic.color
            : Colors.backgroundDefaultInput.color
            
            setTitleColor(isSelected
                          ? Colors.white.color
                          : Colors.textGray.color,
                          for: .normal)
        }
    }
    
    let filterType: SortFilter
    
    init(filterType: SortFilter) {
        self.filterType = filterType
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
