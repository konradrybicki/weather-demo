import XCTest

@testable import WeatherDemo

final class WeatherAPITests: XCTestCase {
    func testGetData_forUrlError() {
        let expectation = XCTestExpectation(description: "Get data but fail with url error.")
        let url: URL? = nil

        WeatherAPI.getData(fromUrl: url) { (result: Result<WeatherData, WeatherAPIError>) in
            switch result {
            case .success(_):
                XCTFail("Unexpected success.")
            case .failure(let failure):
                switch failure {
                case .url:
                    expectation.fulfill()
                default:
                    XCTFail("Failure for unexpected reason.")
                }
            }
        }

        wait(for: [expectation], timeout: 6)
    }

    func testGetData_forNoData() {
        let expectation = XCTestExpectation(description: "Get data but fail with no data.")
        let url: URL? = URL(string: "https://somerandompage.com")

        WeatherAPI.getData(fromUrl: url) { (result: Result<WeatherData, WeatherAPIError>) in
            switch result {
            case .success(_):
                XCTFail("Unexpected success.")
            case .failure(let failure):
                switch failure {
                case .data:
                    expectation.fulfill()
                default:
                    XCTFail("Failure for unexpected reason.")
                }
            }
        }

        wait(for: [expectation], timeout: 6)
    }

    func testGetData_forDecodingError() {
        let expectation = XCTestExpectation(description: "Get data but fail with decoding error.")
        let url: URL? = Endpoints.currentWeather(cityId: 3098334)

        WeatherAPI.getData(fromUrl: url) { (result: Result<Int, WeatherAPIError>) in
            switch result {
            case .success(_):
                XCTFail("Unexpected success.")
            case .failure(let failure):
                switch failure {
                case .decoding:
                    expectation.fulfill()
                default:
                    XCTFail("Failure for unexpected reason.")
                }
            }
        }

        wait(for: [expectation], timeout: 6)
    }

    func testGetData_forSuccess() {
        let expectation = XCTestExpectation(description: "Get data and succeed.")
        let url: URL? = Endpoints.currentWeather(cityId: 3098334)

        WeatherAPI.getData(fromUrl: url) { (result: Result<WeatherData, WeatherAPIError>) in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected failure.")
            }
        }

        wait(for: [expectation], timeout: 6)
    }
}
