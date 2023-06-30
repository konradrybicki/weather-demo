enum WeatherConditions {
    case thunderstorm
    case drizzle
    case rain
    case snow
    case clear
    case clouds
    case atmosphere

    static func from(code weatherCode: Int) -> Self {
        if (200...299).contains(weatherCode) {
            return .thunderstorm
        } else if (300...399).contains(weatherCode) {
            return .drizzle
        } else if (500...599).contains(weatherCode) {
            return .rain
        } else if (600...699).contains(weatherCode) {
            return .snow
        } else if weatherCode == 800 {
            return .clear
        } else if (801...809).contains(weatherCode) {
            return .clouds
        } else {
            return .atmosphere
        }
    }

    // MARK: Symbols
    
    func symbolName(for timeOfDay: TimeOfDay) -> String {
        switch self {
        case .thunderstorm:
            return timeOfDay == .day ? "cloud.sun.bolt" : "cloud.moon.bolt"
        case .drizzle, .rain:
            return timeOfDay == .day ? "cloud.sun.rain" : "cloud.moon.rain"
        case .snow:
            return "cloud.snow"
        case .clear:
            return timeOfDay == .day ? "sun.max" : "moon.stars"
        case .clouds:
            return timeOfDay == .day ? "cloud.sun" : "cloud.moon"
        case .atmosphere:
            return timeOfDay == .day ? "sun.haze" : "moon.haze"
        }
    }
}
