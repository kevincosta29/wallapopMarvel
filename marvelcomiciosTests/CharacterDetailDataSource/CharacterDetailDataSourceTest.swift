//
//  CharacterDetailDataSourceTest.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 15/8/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import XCTest
import KNetwork
@testable import marvelcomicios

class CharacterDetailDataSourceTest: XCTestCase {

    private var seriesData: Data!
    private var arraySeries: [Serie]!
    private var comicsData: Data!
    private var arrayComics: [Comic]!
    private var session = MockNetworking.urlSession
    private let path = "https://gateway.marvel.com:443/v1/public/characters"
    
    override func setUpWithError() throws {
        seriesData = try UnwrapFileHelper.unwrapFileData(name: "characterSeriesMock")
        arraySeries = try KParser.parserData(seriesData)
        
        comicsData = try UnwrapFileHelper.unwrapFileData(name: "characterSeriesMock")
        arrayComics = try KParser.parserData(comicsData)
    }
    
    func test_getComicsSuccess() async throws {
        // Given
        let objResponse = ComicsResponse(code: nil, status: nil, data: ComicsDataResponse(offset: nil, limit: nil, total: nil, count: nil, results: arrayComics))
        let data = try KParser.parserObject(objResponse)
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(statusCode: 200), data)
        }
        
        // When
        let dataSource = CharacterDetailDataSource(session: session)
        let response = await dataSource.getComics(id: 10)
        
        // Then
        switch response {
        case .success(let array):
            XCTAssertEqual(array.count, arraySeries.count)
        case .failure(_):
            XCTFail()
        }
    }
    
    func test_getEmptyComics() async throws {
        let objResponse = ComicsResponse(code: nil, status: nil, data: ComicsDataResponse(offset: nil, limit: nil, total: nil, count: nil, results: nil))
        let data = try KParser.parserObject(objResponse)
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(statusCode: 200), data)
        }
        
        let dataSource = CharacterDetailDataSource(session: session)
        let response = await dataSource.getComics(id: 10)
        
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssert(!error.description.isEmpty)
        }
    }
    
    func test_getComicsFailure() async throws {
        MockURLProtocol.error = KNetworkError.error(message: "")
        let dataSource = CharacterDetailDataSource(session: session)
        let response = await dataSource.getComics(id: 10)
        
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssert(!error.description.isEmpty)
        }
    }
    
    func test_getSeriesSuccess() async throws {
        let objResponse = SeriesResponse(code: nil, status: nil, data: SeriesDataResponse(offset: nil, limit: nil, total: nil, count: nil, results: arraySeries))
        let data = try KParser.parserObject(objResponse)
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(statusCode: 200), data)
        }
        
        let dataSource = CharacterDetailDataSource(session: session)
        let response = await dataSource.getSeries(id: 10)
        
        switch response {
        case .success(let array):
            XCTAssertEqual(array.count, arraySeries.count)
        case .failure(_):
            XCTFail()
        }
    }
    
    func test_getEmptySeries() async throws {
        let objResponse = SeriesResponse(code: nil, status: nil, data: SeriesDataResponse(offset: nil, limit: nil, total: nil, count: nil, results: nil))
        let data = try KParser.parserObject(objResponse)
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(statusCode: 200), data)
        }
        
        let dataSource = CharacterDetailDataSource(session: session)
        let response = await dataSource.getSeries(id: 10)
        
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssert(!error.description.isEmpty)
        }
    }
    
    func test_getSeriesFailure() async throws {
        // Given
        MockURLProtocol.error = KNetworkError.error(message: "")
        
        //When
        let dataSource = CharacterDetailDataSource(session: session)
        let response = await dataSource.getSeries(id: 10)
        
        // Then
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssert(!error.description.isEmpty)
        }
    }
    
    private func prepareResponse(statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: path)!,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil)!
    }
}
