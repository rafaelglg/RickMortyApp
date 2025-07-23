//
//  LoadStateTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 23/7/25.
//

import Testing
@testable import RickMortyApp

struct LoadStateTests {
    
    @Test func initialStates_areEqual() {
        #expect(LoadState<Episode>.initial == LoadState<Episode>.initial)
    }
    
    @Test func loadingStates_areEqual() {
        #expect(LoadState<Episode>.loading == LoadState<Episode>.loading)
    }
    
    @Test func successStates_withEqualData_areEqual() {
        let value = Episode.mock
        #expect(LoadState.success(value) == LoadState.success(value))
    }
    
    @Test func successStates_withDifferentData_areNotEqual() {
        let lhs = Episode.empty
        let rhs = Episode.mock
        #expect(LoadState.success(lhs) != LoadState.success(rhs))
    }
    
    @Test func failureStates_withSameNSError_areEqual() {
        #expect(LoadState<Episode>.failure(APIError.invalidURL) == LoadState<Episode>.failure(APIError.invalidURL))
    }
    
    @Test func failureStates_withDifferentNSError_areNotEqual() {
        #expect(LoadState<Episode>.failure(APIError.itemNotFound) != LoadState<Episode>.failure(AppError.networkError))
    }
    
    @Test func differentCases_areNotEqual() {
        #expect(LoadState<Episode>.initial != LoadState<Episode>.loading)
        #expect(LoadState<Episode>.initial != LoadState<Episode>.success(Episode.mock))
        #expect(LoadState<Episode>.loading != LoadState<Episode>.failure(AppError.networkError))
    }
}
