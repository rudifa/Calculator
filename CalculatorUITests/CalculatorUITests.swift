//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Rudolf Farkas on 21.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import XCTest


extension XCUIApplication {

    /// Tap on buttons specified in `labels`
    ///
    /// - Parameter labels: string of single-character button labels
    func tap(buttons labels: String) {
        for label in labels.split() {
            self.buttons[label].tap()
        }
    }

    /// Taps on buttons specified in `labels` and asserts that display shows the expected text
    ///
    /// - Parameters:
    ///   - labels: string of single-character button labels
    ///   - displayText: expected display text
    func tap(buttons labels: String, expect displayText: String) {
        tap(buttons: labels)
        let display = self.staticTexts["AID_display"]
        XCTAssertEqual(display.label, displayText)
    }

    /// Tap on buttons specified in `labels` and asserts that display shows the expected text
    ///
    /// - Parameters:
    ///   - labels: array of button labels
    ///   - displayText: expected display text
    func tap(buttons labels: [String], expect displayText: String) {
        for label in labels {
            self.buttons[label].tap()
        }
        let display = self.staticTexts["AID_display"]
        XCTAssertEqual(display.label, displayText)
    }
}


class CalculatorUITests: XCTestCase {

    func tapButton(_ label: String) {
        XCUIApplication().buttons[label].tap()
    }

    let app = XCUIApplication()

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
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()
        //print("app.debugDescription=", app.debugDescription)
        // (lldb) po app.debugDescription

        let display = app.staticTexts["AID_display"]
        XCTAssert(display.exists)

        XCTAssertEqual(display.label, "0")
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        XCTAssertEqual(display.label, "123")
        app.buttons["+"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        XCTAssertEqual(display.label, "456")
        app.buttons["="].tap()
        XCTAssertEqual(display.label, "579.0")
        app.buttons["C"].tap()
        XCTAssertEqual(display.label, "0")

        XCTAssert(true)
    }

    func testExample2() {

        let app = XCUIApplication()
        print("app.state", app.state.rawValue)

        let buttons = app.buttons
        XCTAssertEqual(buttons.count, 24)

        let texts = app.staticTexts
        XCTAssertEqual(texts.count, 1)
        let display = texts["AID_display"]

        app.buttons["1"].tap()
        app.buttons["5"].tap()
        app.buttons["9"].tap()
        XCTAssertEqual(display.label, "159")
        app.buttons["="].tap()
        XCTAssertEqual(display.label, "159.0")
        app.buttons["C"].tap()
        XCTAssertEqual(display.label, "0")

        XCTAssert(true)
    }


    func testExample3() {

        let app = XCUIApplication()
        let display = app.staticTexts["AID_display"]
        XCTAssertEqual(display.label, "0")

        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(display.label, "3.0")
    }


    func testExample4() {

        let app = XCUIApplication()
        let display = app.staticTexts["AID_display"]
        XCTAssertEqual(display.label, "0")

        app.buttons["."].tap()
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["."].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(display.label, "0.3")
    }

    func testExample5() {

//        let app = XCUIApplication()
        let display = app.staticTexts["AID_display"]
        app.tap(buttons: "24+56=")
        XCTAssertEqual(display.label, "80.0")
    }

    func testExample6() {

        XCUIApplication().tap(buttons: "", expect: "0")
        XCUIApplication().tap(buttons: "24+56=", expect: "80.0")
        XCUIApplication().tap(buttons: "2.4+5.6=", expect: "8.0")

    }

    func testExample7() {

        app.tap(buttons: "π", expect: "3.14159265358979")
    }
    
    func testExample8() {

        XCTContext.runActivity(named: "Check arithmetic operations") { _ in
            app.tap(buttons: "1000+234=", expect: "1234.0")
            app.tap(buttons: "1000-234=", expect: "766.0")
            app.tap(buttons: "1000×234=", expect: "234000.0")
            app.tap(buttons: "1000÷234=", expect: "4.27350427350427")
        }

        XCTContext.runActivity(named: "Check transcendental operations") { _ in
            app.tap(buttons: ["π"], expect: "3.14159265358979")
            app.tap(buttons: ["π", "cos"], expect: "-1.0")
            app.tap(buttons: ["1", "cos"], expect: "0.54030230586814")
            app.tap(buttons: ["2", "√"], expect: "1.4142135623731")
        }

    }

}
