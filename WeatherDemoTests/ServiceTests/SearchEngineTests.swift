import XCTest

@testable import WeatherDemo

final class SearchEngineTests: XCTestCase {
    func testSearchForCities_forSuccess() {
        let prefix = "katowice"
        let cities = SearchEngine.searchForCities(withPrefix: prefix)
        XCTAssertTrue(cities[0].name == "Katowice")
    }

    func testSearchForCities_forFailure() {
        let prefix = "xxx"
        let cities = SearchEngine.searchForCities(withPrefix: prefix)
        XCTAssertTrue(cities.isEmpty)
    }
}
