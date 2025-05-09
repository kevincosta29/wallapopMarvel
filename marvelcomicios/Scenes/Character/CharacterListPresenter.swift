//
//  File.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 1/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation

protocol CharacterListPresenterInterface {
    var arrayCharacters: [Character] { get }
    
    func viewReady()
    func retryLoad()
    func goToDetail(id: Int)
    func loadNextPage(indexRow: Int)
    func searchFor(text: String)
    func cancelSearch()
}

final class CharacterListPresenter: CharacterListPresenterInterface {
    
    private var dataSource: CharacterListDataSourceProtocol
    private var flowManager: CharacterListFlowManagerProtocol
    private var currentPage = 0
    private var totalPages = 0
    private var originalCharacter = [Character]()
    private var isSearching = false
    weak var view: CharacterListViewInterface?
    var arrayCharacters = [Character]()
    
    init(dataSource: CharacterListDataSourceProtocol,
         flowManager: CharacterListFlowManagerProtocol) {
        self.dataSource = dataSource
        self.flowManager = flowManager
    }
    
    private func retrieveCharacterList() {
        view?.toggleLoading()
        Task { @MainActor in
            let response = await dataSource.getCharacterList(page: currentPage)
            view?.toggleLoading()
            
            switch response {
            case .success((let array, let pages)):
                arrayCharacters.append(contentsOf: array)
                originalCharacter.append(contentsOf: array)
                currentPage += 1
                totalPages = pages ?? 0
                view?.loadContent()
            case .failure(let error):
                view?.show(errorMessage: error.description)
            }
        }
    }
    
    func viewReady() {
        retrieveCharacterList()
    }
    
    func retryLoad() {
        // Something went wrong, so we reset everything to initial state
        currentPage = 0
        totalPages = 0
        retrieveCharacterList()
    }
    
    func goToDetail(id: Int) {
        flowManager.goToDetail(character: arrayCharacters[id])
    }
    
    func loadNextPage(indexRow: Int) {
        if indexRow == arrayCharacters.count - 1 && currentPage < totalPages && !isSearching { // Move to next page and retrieve content
            retrieveCharacterList()
        }
    }
    
    func searchFor(text: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            isSearching = false
            arrayCharacters = originalCharacter
            return
        }
        
        isSearching = true
        arrayCharacters = originalCharacter.filter({ ($0.name ?? "").contains(text) })
    }
    
    func cancelSearch() {
        isSearching = false
        arrayCharacters = originalCharacter
    }
}
