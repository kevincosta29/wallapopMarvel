//
//  ServiceTest.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 3/1/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import XCTest
import KNetwork
@testable import marvelcomicios

class ServiceTest: XCTestCase {

    private var session = MockNetworking.urlSession
    
    func test_Request_Success() async throws {
        // Given
        let mockResponse = CharactersResponse(code: 200, status: "",
                                              data: CharactersDataResponse(offset: 50, limit: 50, total: 50, count: 50, results: []))
        let data = try JSONEncoder().encode(mockResponse)
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(status: 201), data)
        }
        
        // When
        let response = await Service.executeRequest(endpoint: MockCharacterEndPoint.validRequest,
                                                    model: CharactersResponse.self,
                                                    session: session)
        
        // Then
        switch response {
        case .success(let response):
            XCTAssertEqual(response.code, mockResponse.code)
            XCTAssertEqual(response.status, mockResponse.status)
            XCTAssertEqual(response.data?.offset, mockResponse.data?.offset)
            XCTAssertEqual(response.data?.limit, mockResponse.data?.limit)
            XCTAssertEqual(response.data?.total, mockResponse.data?.total)
            XCTAssertEqual(response.data?.count, mockResponse.data?.count)
            XCTAssertEqual(response.data?.results.count, mockResponse.data?.results.count)
        case .failure(_):
            XCTFail()
        }
    }
    
    
    func test_Request_Error() async throws {
        // Given
        let errorExpected = KNetworkError.error(message: "test_Request_Error")
        MockURLProtocol.error = errorExpected
        
        // When
        let response = await Service.executeRequest(endpoint: MockCharacterEndPoint.validRequest,
                                                    model: CharactersResponse.self,
                                                    session: session)
        
        // Then
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, errorExpected.localizedDescription)
        }
        
    }
    
    
    func test_RequestNotValidStatusCode() async throws {
        // Given
        let mockResponse = ErrorResponse(code: "", message: "test_Request_Error")
        let data = try JSONEncoder().encode(mockResponse)
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(status: 401), data)
        }
        
        // When
        let errorExpected = KNetworkError.error(message: mockResponse.description)
        let response = await Service.executeRequest(endpoint: MockCharacterEndPoint.validRequest,
                                                    model: CharactersResponse.self,
                                                    session: session)
        
        // Then
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, errorExpected)
            XCTAssertEqual(error.description, mockResponse.description)
        }
    }
    
    func test_RequestNotValidStatus_InvalidParserData() async throws {
        // Given
        let mockResponse = ErrorResponse(code: "", message: "test_Request_Error")
        let data = try JSONEncoder().encode(mockResponse)
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(status: 401), data)
        }
        
        // When
        let errorExpected = KNetworkError.error(message: mockResponse.description)
        let response = await Service.executeRequest(endpoint: MockCharacterEndPoint.validRequest,
                                                    model: CharactersResponse.self,
                                                    session: session)
        
        // Then
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, errorExpected)
        }
    }
    
    func test_RequestNotValidParserError() async throws {
        // Given
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(status: 401), Data())
        }
        
        // When
        let errorExpected = KNetworkError.error(message: "ERROR RESPONSE - STATUS CODE: \(401)")
        let response = await Service.executeRequest(endpoint: MockCharacterEndPoint.validRequest,
                                                    model: CharactersResponse.self,
                                                    session: session)
        
        // Then
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, errorExpected)
        }
    }
    
    func test_InvalidDataParser_Success() async throws {
        // Given
        let mockResponse = ErrorResponse(code: "", message: "test_Request_Error")
        let data = try JSONEncoder().encode(mockResponse)
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(status: 200), data)
        }
        
        // When
        let errorExpected = KNetworkError.parserError(message: "Can not parser object")
        let response = await Service.executeRequest(endpoint: MockCharacterEndPoint.validRequest,
                                                    model: CharactersResponse.self,
                                                    session: session)
        
        // Then
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, errorExpected)
        }
    }

    private func prepareResponse(status: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "https://gateway.marvel.com:443/v1/public/characters")!,
                        statusCode: status,
                        httpVersion: nil,
                        headerFields: ["Content-Type": "application/json"])!
    }
}
