import XCTest

@testable import WeatherDemo

final class DateTests: XCTestCase {
    func testDateToString() {
        guard let date = createTestDate() else {
            XCTFail("Date creation failure")
            return
        }
        let result = date.toString()
        XCTAssertEqual(result, "1998-04-28 11:00:00")
    }

    private func createTestDate() -> Date? {
        var components = DateComponents()
        components.day = 28
        components.month = 4
        components.year = 1998
        components.hour = 11
        components.minute = 00
        components.second = 00
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components)
    }
}
