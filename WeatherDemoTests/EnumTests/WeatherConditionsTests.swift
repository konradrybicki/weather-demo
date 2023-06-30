import XCTest

@testable import WeatherDemo

// MARK: Codes

final class WeatherConditionsTests: XCTestCase {
    func testFromCode_forThunderstorm() {
        let code = 212
        let conditions = WeatherConditions.from(code: code)
        XCTAssertEqual(conditions, .thunderstorm)
    }

    func testFromCode_forDrizzle() {
        let code = 314
        let conditions = WeatherConditions.from(code: code)
        XCTAssertEqual(conditions, .drizzle)
    }

    func testFromCode_forRain() {
        let code = 502
        let conditions = WeatherConditions.from(code: code)
        XCTAssertEqual(conditions, .rain)
    }

    func testFromCode_forSnow() {
        let code = 612
        let conditions = WeatherConditions.from(code: code)
        XCTAssertEqual(conditions, .snow)
    }

    func testFromCode_forClear() {
        let code = 800
        let conditions = WeatherConditions.from(code: code)
        XCTAssertEqual(conditions, .clear)
    }

    func testFromCode_forClouds() {
        let code = 802
        let conditions = WeatherConditions.from(code: code)
        XCTAssertEqual(conditions, .clouds)
    }
}

// MARK: Symbols

extension WeatherConditionsTests {
    func testSymbolName_forThunderstorm() {
        let conditions: WeatherConditions = .thunderstorm

        let symbolName_day = conditions.symbolName(for: .day)
        let symbolName_night = conditions.symbolName(for: .night)

        XCTAssertEqual(symbolName_day, "cloud.sun.bolt")
        XCTAssertEqual(symbolName_night, "cloud.moon.bolt")
    }

    func testSymbolName_forDrizzle() {
        let conditions: WeatherConditions = .drizzle

        let symbolName_day = conditions.symbolName(for: .day)
        let symbolName_night = conditions.symbolName(for: .night)

        XCTAssertEqual(symbolName_day, "cloud.sun.rain")
        XCTAssertEqual(symbolName_night, "cloud.moon.rain")
    }

    func testSymbolName_forRain() {
        let conditions: WeatherConditions = .rain

        let symbolName_day = conditions.symbolName(for: .day)
        let symbolName_night = conditions.symbolName(for: .night)

        XCTAssertEqual(symbolName_day, "cloud.sun.rain")
        XCTAssertEqual(symbolName_night, "cloud.moon.rain")
    }

    func testSymbolName_forSnow() {
        let conditions: WeatherConditions = .snow
        let symbolName = conditions.symbolName(for: .day)
        XCTAssertEqual(symbolName, "cloud.snow")
    }

    func testSymbolName_forClear() {
        let conditions: WeatherConditions = .clear

        let symbolName_day = conditions.symbolName(for: .day)
        let symbolName_night = conditions.symbolName(for: .night)

        XCTAssertEqual(symbolName_day, "sun.max")
        XCTAssertEqual(symbolName_night, "moon.stars")
    }

    func testSymbolName_forClouds() {
        let conditions: WeatherConditions = .clouds

        let symbolName_day = conditions.symbolName(for: .day)
        let symbolName_night = conditions.symbolName(for: .night)

        XCTAssertEqual(symbolName_day, "cloud.sun")
        XCTAssertEqual(symbolName_night, "cloud.moon")
    }

    func testSymbolName_forAtmosphere() {
        let conditions: WeatherConditions = .atmosphere

        let symbolName_day = conditions.symbolName(for: .day)
        let symbolName_night = conditions.symbolName(for: .night)

        XCTAssertEqual(symbolName_day, "sun.haze")
        XCTAssertEqual(symbolName_night, "moon.haze")
    }
}
