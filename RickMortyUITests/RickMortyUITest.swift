//
//  RickMortyUITest2.swift
//  RickMortyTests
//
//  Created by Rafael Loggiodice on 14/1/23.
//

import XCTest

final class RickMortyUITest: XCTestCase {

    func toggleButtonTest(){

        let app = XCUIApplication()
        app.launch()
        
        let turnForDarkRafaelTurnForLightSwitch = app.switches["Turn for dark, Rafael, Turn for light"]
        turnForDarkRafaelTurnForLightSwitch.tap()
        
        let turnForLightLoggiodiceSwitch = app.switches["Turn for light, Loggiodice"]
        turnForLightLoggiodiceSwitch.tap()
        
    }
    
    func ListTest(){
        let app = XCUIApplication()
        app.launch()

        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let rickSanchezElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Rick Sanchez").element
        rickSanchezElement.swipeUp()
        rickSanchezElement.swipeUp()

        rickSanchezElement.swipeDown()
        rickSanchezElement.swipeDown()

    }
}
