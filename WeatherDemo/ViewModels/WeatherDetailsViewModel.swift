import Foundation

protocol WeatherDetailsObserver: AnyObject {
    func didFetchWeatherDetails()
    func didFail()
}

final class WeatherDetailsViewModel {
    var cityName: String = .empty()
    var weatherConditionsImageName: String = .empty()
    var weatherDescription: String = .empty()
    var temperature = TemperatureViewModel()

    weak var observer: WeatherDetailsObserver?

    func fetchWeatherDetails(cityId: Int) {
        WeatherAPI.getData(fromUrl: Endpoints.currentWeather(cityId: cityId)) { [weak self] (result: Result<WeatherData, WeatherAPIError>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.cityName = model.cityName
                self.weatherConditionsImageName = self.weatherConditionsImageName(from: model)
                self.weatherDescription = model.weather.first?.description.capitalized ?? .empty()
                self.temperature = TemperatureViewModel(model: model.temperature)
                DispatchQueue.main.async { [weak self] in
                    self?.observer?.didFetchWeatherDetails()
                }
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    self?.observer?.didFail()
                }
            }
        }
    }

    private func weatherConditionsImageName(from model: WeatherData) -> String {
        let conditions = WeatherConditions.from(code: model.weather.first?.code ?? 0)
        let timeOfDay = TimeOfDay.from(timeOfCalculation: model.timeOfCalculation,
                                       timeOfSunrise: model.dayBoundaries.timeOfSunrise,
                                       timetimeOfSunset: model.dayBoundaries.timeOfSunset)
        return conditions.symbolName(for: timeOfDay)
    }
}
