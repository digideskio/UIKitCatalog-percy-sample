//
//  UIKitCatalogPercyTests.swift
//  UIKitCatalogPercyTests
//
//  Created by Miklos Fazekas on 02/11/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import XCTest

class UIKitCatalogPercyTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func showCatalog(app: XCUIApplication)
    {
        if !app.navigationBars["UIKitCatalog"].exists {
            app.navigationBars.buttons["UIKitCatalog"].tap()
        }
    }
    
    func testExample() {
        let app = XCUIApplication()
        
        showCatalog(app: app)
        usleep(useconds_t(Double(UINavigationControllerHideShowBarDuration)*1000000.0))
        percySnapshot(path: "UIKitCatalog")

        let tablesQuery = app.tables
        tablesQuery.staticTexts["Alert Controller"].tap()
        tablesQuery.staticTexts["Simple"].tap()

        percySnapshot(path: "Simple Alert")

        app.alerts["A Short Title is Best"].buttons["OK"].tap()
        showCatalog(app: app)

        tablesQuery.staticTexts["ButtonViewController"].tap()

        percySnapshot(path: "Buttons")
        showCatalog(app: app)

        tablesQuery.staticTexts["Page Control"].tap()

        percySnapshot(path: "Page Control")
        showCatalog(app: app)

        tablesQuery.staticTexts["PickerViewController"].tap()

        percySnapshot(path: "PickerViewController")

        showCatalog(app: app)

        tablesQuery.staticTexts["Segmented Controls"].tap()

        percySnapshot(path: "Segmented Controls")

        showCatalog(app: app)
    }
    
}
