//
//  APIErrorTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct APIErrorTests {

    @Test
      func invalidURLEqualityAndDescription() {
          let error1 = APIError.invalidURL
          let error2 = APIError.invalidURL
          
          #expect(error1 == error2)
          #expect(error1.localizedDescription == "The API endpoint URL is invalid.")
      }

      @Test
      func requestFailedEqualityAndDescription() {
          let error1 = APIError.requestFailed(statusCode: 404)
          let error2 = APIError.requestFailed(statusCode: 404)
          let error3 = APIError.requestFailed(statusCode: 500)
          
          #expect(error1 == error2)
          #expect(error1 != error3)
          #expect(error1.localizedDescription == "The API request failed with status code 404.")
      }

      @Test
      func decodingErrorEqualityAndDescription() {
          let decodingError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Corrupted"))
          let error1 = APIError.decodingError(decodingError)
          let error2 = APIError.decodingError(decodingError)

          #expect(error1 == error2)
          #expect(error1.localizedDescription.contains("Failed to process the server's response due to error:"))
      }

      @Test
      func noNextPageEqualityAndDescription() {
          let error1 = APIError.noNextPage
          let error2 = APIError.noNextPage

          #expect(error1 == error2)
          #expect(error1.localizedDescription == "There is no next page available.")
      }

      @Test
      func itemNotFoundEqualityAndDescription() {
          let error1 = APIError.itemNotFound
          let error2 = APIError.itemNotFound

          #expect(error1 == error2)
          #expect(error1.localizedDescription == "The requested character could not be found.")
      }

      @Test
      func unsupportedEndpointEqualityAndDescription() {
          let endpoint = RickMortyEndpoints.character(page: 1)
          let error1 = APIError.unsupportedEndpoint(endpoint: endpoint)
          let error2 = APIError.unsupportedEndpoint(endpoint: endpoint)

          #expect(error1 == error2)
          #expect(error1.localizedDescription == "Endpoint not supported by RickMortyAPI: \(endpoint).")
      }
    
    @Test func rickMortyEndpoints_notEqualValues() async throws {
        let error1 = APIError.invalidURL
        let error2 = APIError.itemNotFound
        
        #expect(error1 != error2)
    }
}
