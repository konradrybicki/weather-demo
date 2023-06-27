import XCTest

@testable import WeatherDemo

final class URLTests: XCTestCase {
    func testUrlForJson_forCorrectFileName() {
        let fileName = "city.list"
        let url = URL.forJson(fileName: fileName)
        XCTAssertNotNil(url)
    }

    func testUrlForJson_forIncorrectFileName() {
        let fileName = "movie.list"
        let url = URL.forJson(fileName: fileName)
        XCTAssertNil(url)
    }
}
