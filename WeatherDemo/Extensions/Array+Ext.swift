extension Array {
    static func empty() -> Self { [] }
}

extension Array where Element == City {
    func viewModel() -> [CityViewModel] {
        map({ city in CityViewModel(model: city)})
    }
}
