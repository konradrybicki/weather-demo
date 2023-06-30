import Foundation

struct Endpoints {
    static func currentWeather(cityId: Int) -> URL? {
        URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(Strings.apiKey)&units=metric")
    }
}
