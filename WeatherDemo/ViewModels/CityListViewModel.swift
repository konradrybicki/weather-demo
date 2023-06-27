protocol CityListObserver: AnyObject {
    func cityListDidUpdate(_ cityList: [CityViewModel])
}

final class CityListViewModel {
    var cities = [CityViewModel]()
    weak var observer: CityListObserver?

    func getCities(byPrefix prefix: String) {
        cities = SearchEngine.searchForCities(withPrefix: prefix).viewModel()
        observer?.cityListDidUpdate(cities)
    }
}
