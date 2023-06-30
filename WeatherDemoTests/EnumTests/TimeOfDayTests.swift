import XCTest

@testable import WeatherDemo

final class TimeOfDayTests: XCTestCase {
    func testFromTime() {
        let timeOfCalculation = 1687908078
        let timeOfSunrise = 1687919680
        let timeOfSunset = 1687978716

        let timeOfDay = TimeOfDay.from(timeOfCalculation: timeOfCalculation,
                                       timeOfSunrise: timeOfSunrise,
                                       timetimeOfSunset: timeOfSunset)

        XCTAssertEqual(timeOfDay, .night)
    }
}
