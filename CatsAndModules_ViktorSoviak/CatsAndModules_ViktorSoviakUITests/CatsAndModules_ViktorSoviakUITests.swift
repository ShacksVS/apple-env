//
//  CatsAndModules_ViktorSoviakUITests.swift
//  CatsAndModules_ViktorSoviakUITests
//
//  Created by Viktor Sovyak on 6/10/24.
//

import XCTest

final class CatsAndModules_ViktorSoviakUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor func testScreenshots() throws {
        let app = XCUIApplication()
        app.launch()
        
        setupSnapshot(app)
        
//        let alert = app.alerts["Collect data about crashes"]
//        XCTAssertTrue(
//            alert.waitForExistence(timeout: 5),
//            "The consent alert did not appear."
//        )
//        alert.buttons["Cancel"].tap()
        
        sleep(5)

        snapshot("Sovyak_MainScreen")
                
        let animalCell = app.otherElements["animal"].firstMatch
        XCTAssertTrue(animalCell.exists)
        
        animalCell.tap()
        
        sleep(5)
        snapshot("Sovyak_DetailScreen")
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
