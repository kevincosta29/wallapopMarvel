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
    private let loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.startAnimating()
        loading.style = .large
        loading.isHidden = true
        return loading
    }()
    private lazy var buttonRetry: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.Default.errorMessage, for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapButtonRetry)))
        button.isHidden = true
        return button
    }()
    
    private var presenter: CharacterListPresenterInterface
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(presenter: CharacterListPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = false
        title = Localization.CharacterList.title
        
        setupSearchBar()
        setupTableView()
        
        view.addToParent(loading)
        view.addToParent(buttonRetry)
        
        presenter.viewReady()
    }
}

extension CharacterListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        // Update filtered content
        guard let text = searchController.searchBar.text else {
            return
        }
        presenter.searchFor(text: text)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.cancelSearch()
        tableView.reloadData()
    }
}

extension CharacterListViewController: CharacterListViewInterface {
    func toggleLoading() {
        loading.isHidden = !loading.isHidden
    }
    
    func show(errorMessage: String) {
        buttonRetry.setTitle(errorMessage, for: .normal)
        tableView.isHidden = true
    }
    
    func loadContent() {
        tableView.isHidden = false
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
    
    @objc func tapButtonRetry() {
        presenter.retryLoad()
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Localization.CharacterList.searchBarPalceHolder
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.loadNextPage(indexRow: indexPath.row)
    }
    
}
