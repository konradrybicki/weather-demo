struct CityViewModel {
    private let model: City

    init(model: City) {
        self.model = model
    }

    var cityId: Int {
        model.id
    }

    var displayName: String {
        if model.state.isEmpty {
            return model.name + ", " + model.country
        } else {
            return model.name + ", " + model.state + ", " + model.country
        }
    }
}
