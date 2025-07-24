//
//  CharacterViewUITests.swift
//  CharacterViewUITests
//
//  Created by Rafael Loggiodice on 16/7/25.
//

import XCTest
@testable import RickMortyApp

@MainActor
final class CharacterViewUITests: XCTestCase {

    let app: XCUIApplication = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_characterViewList_enterFirstCell_andBack() {
        
        let collectionViewsQuery = app.collectionViews
        let firstCell = collectionViewsQuery.buttons["CharacterCell_\(1)"]
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        let characterName = collectionViewsQuery.staticTexts["CharacterNames"]
        XCTAssertTrue(characterName.exists)
        
        let collection = app.collectionViews.firstMatch
        let cellCount = collection.cells.count
        
        for index in 0..<cellCount {
            let cell = collection.cells.element(boundBy: index)
            if cell.exists {
                cell.swipeUp()
            }
        }
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func test_characterViewList_enterRandomCell_andBack() {
        
        let collection = app.collectionViews.firstMatch
        XCTAssertTrue(collection.waitForExistence(timeout: 5), "Collection view should exist")
        
        let randomIndex = Int.random(in: 0..<6)
        let selectedCell = collection.buttons["CharacterCell_\(randomIndex)"]
        
        XCTAssertTrue(selectedCell.exists, "Random cell should exist")
        selectedCell.tap()
        
        let characterName = app.staticTexts["CharacterNames"]
        XCTAssertTrue(characterName.waitForExistence(timeout: 5), "Character name label should appear on detail screen")
        
        let detailCollection = app.collectionViews.firstMatch
        let cellCount = detailCollection.cells.count
        
        for index in 0..<cellCount {
            let cell = detailCollection.cells.element(boundBy: index)
            if cell.exists {
                cell.swipeUp()
            }
        }
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func test_characterViewList_loadMoreCharacter_andTap() {
        let collection = app.collectionViews.firstMatch
        XCTAssertTrue(collection.waitForExistence(timeout: 5))

        let targetIndex = 50
        let maxSwipes = 10
        var swipeCount = 0

        let targetCell = collection.buttons["CharacterCell_\(targetIndex)"]

        while (!targetCell.exists || !targetCell.isHittable) && swipeCount < maxSwipes {
            collection.swipeUp()
            swipeCount += 1
            sleep(1)
        }

        XCTAssertTrue(targetCell.exists && targetCell.isHittable, "Cell \(targetIndex) should be visible and tappable")
        targetCell.tap()

        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func test_tabbarView_tapInSettings() {
        let tabBar = app.tabBars.firstMatch
        let settingsTab = tabBar.buttons.element(boundBy: 1)
        XCTAssertTrue(settingsTab.exists)
        settingsTab.tap()

        let settingsTitle = app.collectionViews.staticTexts["AppStorageSectionHeader"]
        XCTAssertTrue(settingsTitle.waitForExistence(timeout: 5))
    }
    
    func test_tabbarView_tapInSettings_tapClearCache() {
        let tabBar = app.tabBars.firstMatch
        let settingsTab = tabBar.buttons.element(boundBy: 1)
        XCTAssertTrue(settingsTab.exists)
        settingsTab.tap()

        let clearCacheButton = app.collectionViews.buttons["clearCacheButton"]
        XCTAssertTrue(clearCacheButton.waitForExistence(timeout: 5))
        clearCacheButton.tap()
        
        let deleteButton = app.buttons["deleteCacheButton"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 5))
        deleteButton.tap()
        
        XCTAssertTrue(clearCacheButton.waitForExistence(timeout: 5))
        XCTAssertFalse(clearCacheButton.isEnabled)
                
    }
}
