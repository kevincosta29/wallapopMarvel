//
//  CharacterDetailPresenterTest.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 4/1/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import XCTest
import KNetwork
@testable import marvelcomicios

class CharacterDetailPresenterTest: XCTestCase {
    
    private var dataSource: MockedCharacterDetailDataSource!
    private var mockCharacter = Character(id: 50, name: "", description: "", modified: "", thumbnail: nil)

    override func setUpWithError() throws {
        dataSource = MockedCharacterDetailDataSource()
    }

    override func tearDownWithError() throws { }
    
    func test_GetComics_Success() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_GetComics_Success")
        let mockDataResponse = try UnwrapFileHelper.unwrapFileData(name: "characterComicsMock")
        let mockObjectResponse: [Comic] = try KParser.parserData(mockDataResponse)

        dataSource.resultComics = .success(mockObjectResponse)
        let presenter = CharacterDetailPresenter(dataSource: dataSource, character: mockCharacter)
        let mockView = CharacterDetailViewMock()
        mockView.expectationLoad = expectation
        presenter.view = mockView

        // When
        presenter.viewReady()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(mockView.loadedComics.count, mockObjectResponse.count)
        XCTAssertEqual(mockView.toggleLoadingCount, 2)
    }
    
    
    func test_GetComicsNilData_Success() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_GetComicsNilData_Success")
        dataSource.resultComics = .success([])
        let presenter = CharacterDetailPresenter(dataSource: dataSource, character: mockCharacter)
        let mockView = CharacterDetailViewMock()
        presenter.view = mockView
        mockView.expectationLoad = expectation
        
        // When
        presenter.viewReady()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(mockView.loadedComics.count, 0)
        XCTAssertEqual(mockView.toggleLoadingCount, 2)
    }
    
    func test_GetComics_Failure() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_GetComics_Failure")
        dataSource.resultComics = .failure(KNetworkError.error(message: "test_GetComics_Failure"))
        let presenter = CharacterDetailPresenter(dataSource: dataSource, character: mockCharacter)
        let mockView = CharacterDetailViewMock()
        presenter.view = mockView
        mockView.expectationLoad = expectation
        
        // When
        presenter.viewReady()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mockView.loadedComics.isEmpty)
        XCTAssertEqual(mockView.toggleLoadingCount, 2)
    }
    
    func test_GetSeries_Success() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_GetSeries_Success")
        let mockDataResponse = try UnwrapFileHelper.unwrapFileData(name: "characterSeriesMock")
        let mockObjectResponse: [Serie] = try KParser.parserData(mockDataResponse)
        dataSource.resultSeries = .success(mockObjectResponse)
        let presenter = CharacterDetailPresenter(dataSource: dataSource, character: mockCharacter)
        let mockView = CharacterDetailViewMock()
        presenter.view = mockView
        mockView.expectationLoad = expectation
        
        // When
        presenter.viewReady()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(mockView.loadedSeries.count, mockObjectResponse.count)
        XCTAssertEqual(mockView.toggleLoadingCount, 2)
    }
    
    func test_GetSeriesNilData_Success() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_GetSeriesNilData_Success")
        dataSource.resultSeries = .success([])
        let presenter = CharacterDetailPresenter(dataSource: dataSource, character: mockCharacter)
        let mockView = CharacterDetailViewMock()
        presenter.view = mockView
        mockView.expectationLoad = expectation
        
        // When
        presenter.viewReady()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(mockView.loadedSeries.count, 0)
        XCTAssertEqual(mockView.toggleLoadingCount, 2)
    }
    
    func test_GetSeries_Failure() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_GetSeries_Failure")
        dataSource.resultSeries = .failure(KNetworkError.error(message: "test_GetSeries_Failure"))
        let presenter = CharacterDetailPresenter(dataSource: dataSource, character: mockCharacter)
        let mockView = CharacterDetailViewMock()
        presenter.view = mockView
        mockView.expectationLoad = expectation
        
        // When
        presenter.viewReady()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(mockView.loadedSeries.isEmpty)
        XCTAssertEqual(mockView.toggleLoadingCount, 2)
    }

}
