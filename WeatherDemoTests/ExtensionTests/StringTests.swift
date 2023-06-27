import XCTest

@testable import WeatherDemo

final class StringTests: XCTestCase {
    func testMatchesRegex_forMatch() {
        guard let regex = try? NSRegularExpression(pattern: "weathe?r") else {
            XCTFail("Regex creation failure")
            return
        }
        let string = "weather"
        XCTAssertTrue(string.matches(regex))
    }

    func testMatchesRegex_forMismatch() {
        guard let regex = try? NSRegularExpression(pattern: "weathe?r") else {
            XCTFail("Regex creation failure")
            return
        }
        let string = "rain"
        XCTAssertFalse(string.matches(regex))
    }
}
