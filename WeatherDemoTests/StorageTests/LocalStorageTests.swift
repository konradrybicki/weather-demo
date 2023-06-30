import XCTest

@testable import WeatherDemo

final class LocalStorageTests: XCTestCase {
    func testInitialize() {
        LocalStorage.initialize()
        XCTAssertNotNil(LocalStorage.cityList)
    }
}
