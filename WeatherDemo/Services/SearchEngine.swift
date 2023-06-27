struct SearchEngine {
    static func searchForCities(withPrefix prefix: String) -> [City] {
        LocalStorage.cityList?.filter({ city in city.name.lowercased().hasPrefix(prefix)}) ?? []
    }
}
