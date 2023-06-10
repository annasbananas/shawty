import ArtistIOS
import SharedIOS
import Testing
import XCTest

final class AppUIAcceptanceTests: UITestCase {
  func test_artistSearchHappyPath() {
    // Shows No results
    expect(text(withTitle: SharedIOSStrings.noSearchTitle))

    // Search for artist
    let artistSearchField = searchField(withTitle: ArtistIOSStrings.artistSearchPrompt)
    artistSearchField.tap()
    waitUntilElementHasFocus(element: artistSearchField)
      .typeText("Kygo")

    // Tap on first artist
    cell(withTitle: "Kygo").tap()

    // Tap on first album
    cell(withTitle: "Thrill Of The Chase").tap()

    // Tap on first track
    cell(withTitle: "Gone Are The Days (feat. James Gillespie)").tap()

    // Tap on alert
    alert(withTitle: "'Playing' Track")
      .button(withTitle: "OK")
      .tap()

    navigationBarBackButton().tap()
    navigationBarBackButton().tap()
  }
}
