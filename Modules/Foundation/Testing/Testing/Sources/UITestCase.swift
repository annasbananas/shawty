import XCTest

open class UITestCase: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  public var app: XCUIApplication!

  open override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  public func cell(
    withTitle title: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.collectionViews.cells.staticTexts[title]
      .waitUntilExists(file: file, line: line)
  }

  public func alert(
    withTitle title: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.alerts[title]
      .waitUntilExists(file: file, line: line)
  }

  public func searchField(
    withTitle title: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.searchFields[title].waitUntilExists()
      .waitUntilExists(file: file, line: line)
  }

  public func text(
    withTitle title: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.staticTexts[title]
      .waitUntilExists(file: file, line: line)
  }

  public func navigationBarBackButton(
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.navigationBars.buttons.element(boundBy: 0)
      .waitUntilExists(file: file, line: line)
  }

  public func button(
    withTitle title: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.buttons[title]
      .waitUntilExists(file: file, line: line)
  }

  public func expect(
    _ element: XCUIElement,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    XCTAssertTrue(element.exists, file: file, line: line)
  }
}
