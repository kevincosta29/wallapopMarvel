//
//  CharacterListViewController.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 1/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterListViewInterface: AnyObject {
    func toggleLoading()
    func show(errorMessage: String)
    func loadContent()
}

final class CharacterListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewLoading = UIView()
    
    private var presenter: CharacterListPresenterInterface
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: CharacterListPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = false
        
        self.title = "character.title".localized()
        
        setupTableView()
        
        view.addToParent(viewLoading)
        viewLoading.addLottie()
        viewLoading.isHidden = true
        // viewLoading.backgroundColor = .red
        
        presenter.viewReady()
    }
}

extension CharacterListViewController: CharacterListViewInterface {
    func toggleLoading() {
        viewLoading.isHidden = !viewLoading.isHidden
    }
    
    func show(errorMessage: String) {
        
    }
    
    func loadContent() {
        tableView.reloadData()
    }
}

private extension CharacterListViewController {
    func setupTableView() {
        view.addToParent(tableView)
        tableView.register(CharacterCell.self, forCellReuseIdentifier: String(describing: CharacterCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDelegate

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.arrayCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterCell.self)) as? CharacterCell else {
            return UITableViewCell()
        }
        
        let object = presenter.arrayCharacters[indexPath.row]
        cell.configure(with: object)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToDetail(id: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
