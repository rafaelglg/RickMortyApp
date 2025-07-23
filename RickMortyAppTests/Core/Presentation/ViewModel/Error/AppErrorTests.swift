//
//  AppErrorTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 23/7/25.
//

import Testing
@testable import RickMortyApp

struct AppErrorTests {

    @Test func appError_localizedDescription_hasValue() async throws {
        #expect(AppError.networkError.errorDescription == "No internet connection. Please check your network settings.")
        
    }
}
