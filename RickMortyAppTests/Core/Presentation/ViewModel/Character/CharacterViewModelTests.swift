//
//  CharacterViewModelTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 23/7/25.
//

import Testing
@testable import RickMortyApp

@MainActor
struct CharacterViewModelTests {
    
    var useCaseMock: CharacterUseCaseMock = CharacterUseCaseMock()
    var networkMock: NetworkManagerMock = NetworkManagerMock()
    var sut: CharacterViewModelImpl
    
    init() {
        sut = CharacterViewModelImpl(useCase: useCaseMock, network: networkMock)
    }
    
    @Test func getCharacters_returnsEarly_CacheExist() async {
        useCaseMock.cachedCharacter = CharacterContainer(info: .empty, results: Character.mocks)
        await sut.performGetCharacters()
        await sut.getCharacters()
        
        #expect(useCaseMock.cacheExists == true)
        #expect(sut.loadState != .loading)
    }

    @Test func performGetCharacters_returnsCachedCharacter() async {
        useCaseMock.cachedCharacter = CharacterContainer(info: .empty, results: Character.mocks)
        await sut.performGetCharacters()
        
        #expect(sut.loadState == .success(Character.mocks))
    }
    
    @Test func performGetCharacters_returnsFromUseCase() async {
        useCaseMock.cachedCharacter = nil
        await sut.performGetCharacters()
        
        #expect(sut.paginationInfo?.info.pages == Info.empty.pages)
        #expect(sut.loadState == .success(Character.mocks))
    }
    
    @Test func performGetCharacters_throwsError() async {
        useCaseMock.cachedCharacter = nil
        useCaseMock.executeError = AppError.networkError
        await sut.performGetCharacters()
        
        #expect(sut.loadState == .failure(AppError.networkError))
    }
    
    @Test("This functions should return an error when the user is offline and try to load more characters")
    func loadMoreCharacters_loadMoreError_Equals_AppErrorNetworkError() async {
        networkMock.isConnected = false
        await sut.loadMoreCharacters()
        
        #expect(sut.loadMoreError as? AppError == AppError.networkError)
    }
    
    @Test
    func loadMoreCharacters_returnsValidData() async {
        await sut.loadMoreCharacters()
        
        #expect(sut.characters == Character.mocks)
        #expect(sut.paginationInfo?.info.count == Info.empty.count)
    }
    
    @Test("This function should return an error when the user is offline and try to load more characters")
    func loadMoreCharacters_throwsError() async {
        useCaseMock.executeError = AppError.networkError
        await sut.loadMoreCharacters()
        
        #expect(sut.loadState == .failure(AppError.networkError))
    }
    
    @Test
    func searchCharacters_queryIsEmpty() async {
        let query = ""
        await sut.searchCharacters(query: query)
        
        #expect(sut.characters == Character.mocks)
        #expect(sut.paginationInfo?.info.count == Info.empty.count)
    }
    
    @Test
    func searchCharacters_returnValidData() async {
        let query = "batman"
        await sut.searchCharacters(query: query)
        
        #expect(sut.characters == Character.mocks)
        #expect(sut.paginationInfo?.info.count == Info.empty.count)
    }
    
    @Test
    func searchCharacters_throwsError() async {
        let query = "batman"
        useCaseMock.executeError = AppError.networkError
        await sut.searchCharacters(query: query)
        
        #expect(sut.loadState == .failure(AppError.networkError))
    }
    
}
