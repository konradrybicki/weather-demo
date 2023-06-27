import XCTest

@testable import WeatherDemo

final class JSONReaderTests: XCTestCase {
    func testReadFromFile_forSuccess() throws {
        let fileName = Strings.cityListFileName
        let cities: [City] = try JSONReader.read(fromFile: fileName)
        XCTAssertFalse(cities.isEmpty)
    }

    func testReadFromFile_forFileError() {
        let expectation = XCTestExpectation(description: "Read json but fail with file error")
        // given
        let fileName = "something"
        do {
            // when
            let _: [City] = try JSONReader.read(fromFile: fileName)
            XCTFail("Unexpected success")
        } catch(let exception) {
            // then
            if let error = exception as? JSONReaderError, error == .file {
                expectation.fulfill()
            } else {
                XCTFail("Unexpected failure")
            }
        }
    }

    func testReadFromFile_forDecodingError() {
        let expectation = XCTestExpectation(description: "Read json but fail with decoding error")
        // given
        let numbers: [Int]
        do {
            // when
            numbers = try JSONReader.read(fromFile: Strings.cityListFileName)
            XCTFail("Unexpected success" + numbers.description)
        } catch(let exception) {
            // then
            if let error = exception as? JSONReaderError, error == .decoding {
                expectation.fulfill()
            } else {
                XCTFail("Unexpected failure")
            }
        }
    }
}
