import UIKit

struct TemperatureViewModel {
    private let model: Temperature

    init(model: Temperature) {
        self.model = model
    }

    init() {
        self.model = Temperature(value: 0)
    }

    var label: String {
        "\(Int(model.value))℃"
    }

    var color: UIColor {
        if model.value < 10 {
            return Colors.peterRiver
        } else if model.value < 20 {
            return Colors.primaryContent
        } else {
            return .red
        }
    }
}
