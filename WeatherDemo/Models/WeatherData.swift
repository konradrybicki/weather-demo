struct WeatherData: Decodable {
    let weather: [Weather]
    let temperature: Temperature
    let timeOfCalculation: Int
    let dayBoundaries: DayBoundaries
    let cityName: String

    enum CodingKeys: String, CodingKey {
        case weather
        case temperature = "main"
        case timeOfCalculation = "dt"
        case dayBoundaries = "sys"
        case cityName = "name"
    }
}

struct Weather: Decodable {
    let code: Int
    let description: String

    enum CodingKeys: String, CodingKey {
        case code = "id"
        case description
    }
}

struct Temperature: Decodable {
    let value: Float

    enum CodingKeys: String, CodingKey {
        case value = "temp"
    }
}

struct DayBoundaries: Decodable {
    let timeOfSunrise: Int
    let timeOfSunset: Int

    enum CodingKeys: String, CodingKey {
        case timeOfSunrise = "sunrise"
        case timeOfSunset = "sunset"
    }
}
