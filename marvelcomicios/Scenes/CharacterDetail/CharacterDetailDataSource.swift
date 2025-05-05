//
//  CharacterDetailDataSource.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 12/7/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import Foundation
import KNetwork

protocol CharacterDetailDataSourceProtocol {
    func getComics(id: Int) async -> (Result<[Comic], KNetworkError>)
    func getSeries(id: Int) async -> (Result<[Serie], KNetworkError>)
}

class CharacterDetailDataSource: CharacterDetailDataSourceProtocol {
    
    //-----------------------
    // MARK: VARIABLES
    // MARK: ============
    //-----------------------
    
    private let session: URLSession
    
    //-----------------------
    // MARK: - INIT
    //-----------------------
    
    init(session: URLSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)) {
        self.session = session
    }
    
    //-----------------------
    // MARK: - METHODS
    //-----------------------
    
    func getComics(id: Int) async -> (Result<[Comic], KNetworkError>) {
        let endPoint = MarvelComicsEndpoint.wsGetCharacterComics(id: id)
        let response = await Service.executeRequest(endpoint: endPoint, model: WSComicsResponse.self, session: session)
        
        switch response {
        case .success(let response):
            if let array = response.data?.results, !array.isEmpty {
                return .success(array)
            } else {
                return .failure(KNetworkError.error(message: Localization.Default.errorMessage))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getSeries(id: Int) async -> (Result<[Serie], KNetworkError>) {
        let endPoint = MarvelComicsEndpoint.wsGetCharacterSeries(id: id)
        let response = await Service.executeRequest(endpoint: endPoint, model: WSSeriesResponse.self, session: session)
        
        switch response {
        case .success(let response):
            if let array = response.data?.results, !array.isEmpty {
                return .success(array)
            } else {
                return .failure(KNetworkError.error(message: Localization.Default.errorMessage))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
