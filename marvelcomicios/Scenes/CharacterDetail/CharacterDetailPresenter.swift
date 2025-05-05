//
//  CharacterDetailViewModel.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 28/12/21.
//  Copyright © 2021 Kevin Costa. All rights reserved.
//

import Foundation
import KNetwork

protocol CharacterDetailPresenterInterface {
    var character: Character { get }
    
    func viewReady()
    func retryLoad()
    func openModal()
}

final class CharacterDetailPresenter: CharacterDetailPresenterInterface {
    
    //-----------------------
    // MARK: VARIABLES
    // MARK: ============
    //-----------------------
    
    var character: Character
    private var arrayComics: [Comic] = []
    private var arraySeries: [Serie] = []
    weak var view: CharacterDetailViewInterface?
    private let dataSource: CharacterDetailDataSourceProtocol
    private let flowManager: CharacterDetailFlowManagerProtocol
    
    //-----------------------
    // MARK: - LIVE APP
    //-----------------------
    
    init(dataSource: CharacterDetailDataSourceProtocol,
         flowManager: CharacterDetailFlowManagerProtocol,
         character: Character) {
        self.dataSource = dataSource
        self.flowManager = flowManager
        self.character = character
    }
    
    //-----------------------
    // MARK: - METHODS
    //-----------------------
    
    func viewReady() {
        guard let id = character.id else {
            view?.showError(errorMessage: Localization.Default.errorMessage)
            return
        }
        
        Task { @MainActor in
            view?.toggleLoading()
            await retrieveComics(id: id)
            await retrieveSeries(id: id)
            view?.toggleLoading()
            // We can use a mapper instead of doing it in that way
            view?.loadContent(series: arraySeries.map { SectionItem(urlImage: $0.thumbnail?.urlImg, title: $0.title) },
                              comics: arrayComics.map { SectionItem(urlImage: $0.thumbnail?.urlImg, title: $0.title) },)
        }
    }
    
    func openModal() {
        guard let links = character.urls else {
            return
        }
        flowManager.openModal(arrayLinks: links)
    }
    
    func retryLoad() {
        viewReady()
    }
}

private extension CharacterDetailPresenter {
    func retrieveComics(id: Int) async {
        arrayComics = []
        let responseComics = await dataSource.getComics(id: character.id ?? 0)
        if case .success(let array) = responseComics {
            arrayComics = array
        }
    }
    
    func retrieveSeries(id: Int) async {
        arraySeries = []
        let responseSeries = await dataSource.getSeries(id: character.id ?? 0)
        if case .success(let array) = responseSeries {
            arraySeries = array
        }
    }
}
