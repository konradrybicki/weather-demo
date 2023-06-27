struct LocalStorage {
    static var cityList: [City]?

    static func initialize() {
        cityList = try? JSONReader.read(fromFile: Strings.cityListFileName)
    }
}
