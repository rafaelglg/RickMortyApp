//
//  ApiServiceTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
import Foundation
@testable import RickMortyApp

struct ApiServiceTests {
    
    let service = APIServiceImpl()
    
    @Test
    func testHandleResponse_StatusCodeInvalid() {
        let response = URLResponse()
        
        do {
            try service.handleResponse(response: response)
            Issue.record("Should throw requestFailed error with -1 status code")
        } catch {
            #expect(error == .requestFailed(statusCode: -1))
        }
    }

    @Test
      func testHandleResponseSuccess() throws {
          let response = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                         statusCode: 200,
                                         httpVersion: nil,
                                         headerFields: nil)!
          
          try service.handleResponse(response: response)
      }

      @Test
      func testHandleResponseItemNotFound() {
          let response = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                         statusCode: 404,
                                         httpVersion: nil,
                                         headerFields: nil)!
          
          do {
              try service.handleResponse(response: response)
          } catch {
              #expect(error == .itemNotFound)
          }
      }

      @Test
      func testHandleResponseOtherError() {
          let response = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                         statusCode: 500,
                                         httpVersion: nil,
                                         headerFields: nil)!
          
          do {
              try service.handleResponse(response: response)
          } catch {
              #expect(error == .requestFailed(statusCode: 500))
          }
      }
}
