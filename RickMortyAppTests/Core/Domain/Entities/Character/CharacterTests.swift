//
//  CharacterTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct CharacterTests {
    
    @Test("imageURL should return a valid URL for a correct string")
    func imageURL_withValidString() {
        let validURLString = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        let character = createTestCharacter(image: validURLString)
        
        let resultURL = character.imageURL
        
        #expect(resultURL.scheme == "https")
        #expect(resultURL.host() == "rickandmortyapi.com")
        #expect(resultURL.isFileURL == false, "The URL should not be a local file URL.")
    }
    
    @Test("imageURL should return an empty file path URL for an empty string")
    func imageURL_withEmptyString() {
        let character = createTestCharacter(image: "")
        
        let resultURL = character.imageURL
        #expect(resultURL.isFileURL == true, "The URL should be a local file URL for an invalid string.")
        #expect(resultURL.path() == "./")
    }
    
    @Test("imageURL should return an empty file path URL for a malformed string")
    func imageURL_withMalformedString() {
        let character = createTestCharacter(image: "this is not a url")
        
        let resultURL = character.imageURL
        #expect(resultURL.isFileURL == false)
    }
    
    // MARK: - Tests for `formattedCreatedDate` Computed Property
    @Test("formattedCreatedDate should correctly format a valid ISO 8601 string")
    func formattedCreatedDate_withValidString() {
        
        let isoDateString = "2017-11-04T18:48:46.250Z"
        let character = createTestCharacter(created: isoDateString)
        
        let formattedDate = character.formattedCreatedDate
        #expect(formattedDate.contains("2017"), "The formatted date should contain the year.")
        #expect(formattedDate.contains("nov"), "The formatted date should contain the month.")
        #expect(formattedDate.contains("4"), "The formatted date should contain the day.")
    }
    
    @Test("formattedCreatedDate should return an empty string for an empty date string")
    func formattedCreatedDate_withEmptyString() {
        let character = createTestCharacter(created: "")
        let formattedDate = character.formattedCreatedDate
        
        #expect(formattedDate.isEmpty == true, "The formatted date should be an empty string.")
    }
    
    @Test("formattedCreatedDate should return an empty string for a malformed date string")
    func formattedCreatedDate_withMalformedString() {
        
        let character = createTestCharacter(created: "yesterday afternoon")
        let formattedDate = character.formattedCreatedDate

        #expect(formattedDate.isEmpty == true)
    }
    
    @Test("Character should be empty")
    func character_shouldBeEmpty() {
        let emptyCharacter = Character.empty
        
        #expect(emptyCharacter.id == 0)
        #expect(emptyCharacter.gender.isEmpty)
    }
    
    // MARK: - Helper Function
    /// Creates a `Character` instance with default values, allowing
    /// specific properties to be overridden for each test.
    private func createTestCharacter(
        image: String? = nil,
        created: String? = nil
    ) -> Character {
        return Character(
            id: 1, name: "Test Character", status: "", species: "", type: "", gender: "",
            origin: Origin(name: "", url: ""),
            location: Location(name: "", url: ""),
            image: image ?? "https://example.com/image.png",
            episodes: [],
            url: "",
            created: created ?? "2024-01-01T12:00:00.000Z"
        )
    }
    
    @Test("Info Model should be empty")
    func info_shouldBeEmpty() {
        let infoEmpty = Info.empty
        // swiftlint:disable:next empty_count
        #expect(infoEmpty.count == 0)
        #expect(infoEmpty.pages == 0)
        #expect(infoEmpty.next == nil)
        #expect(infoEmpty.prev == nil)
    }
}
