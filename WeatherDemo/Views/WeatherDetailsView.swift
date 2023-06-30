import SnapKit
import UIKit

final class WeatherDetailsView: UIView {
    struct Layout {
        static let stackViewSpacing: CGFloat = 15
    }

    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSizes.large)
        label.text = cityName
        label.textColor = Colors.primaryContent
        label.textAlignment = .center
        return label
    }()

    private lazy var conditionsImageView: UIImageView? = {
        guard #available(iOS 13.0, *) else { return nil }
        let image = UIImage(systemName: weatherConditionsImageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryContent
        return imageView
    }()

    private lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSizes.big)
        label.text = weatherDescription
        label.textColor = Colors.primaryContent
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSizes.big)
        label.text = temperature.label
        label.textColor = temperature.color
        label.textAlignment = .center
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityNameLabel, weatherDescriptionLabel, temperatureLabel])
        conditionsImageView.map({ imageView in stackView.insertArrangedSubview(imageView, at: 1)})
        stackView.axis = .vertical
        stackView.spacing = Layout.stackViewSpacing
        return stackView
    }()

    private let cityName: String
    private let weatherConditionsImageName: String
    private let weatherDescription: String
    private let temperature: TemperatureViewModel

    init(cityName: String,
         weatherConditionsImageName: String,
         weatherDescription: String,
         temperature: TemperatureViewModel) {
        self.cityName = cityName
        self.weatherConditionsImageName = weatherConditionsImageName
        self.weatherDescription = weatherDescription
        self.temperature = temperature
        super.init(frame: .zero)
        addSubview(stackView)
        setUpConstraints()
    }

    required init?(coder: NSCoder) { nil }

    private func setUpConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        conditionsImageView?.snp.makeConstraints({ make in
            make.width.equalTo(GlobalLayout.largeImageSize)
            make.height.equalTo(GlobalLayout.largeImageSize)
        })
    }
}
