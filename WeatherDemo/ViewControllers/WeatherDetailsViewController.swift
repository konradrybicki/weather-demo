import SnapKit
import UIKit

enum WeatherDetailsViewState {
    case loading
    case success
    case failure
}

final class WeatherDetailsViewController: UIViewController {
    private lazy var topSafeAreaView = UIView()
    private lazy var navigationBar = NavigationBar(navigationTitle: "Details", cancelButtonAction: dismiss)
    private lazy var contentView = UIView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topSafeAreaView, navigationBar, contentView])
        stackView.axis = .vertical
        return stackView
    }()

    private let viewModel = WeatherDetailsViewModel()
    private let cityId: Int

    init(cityId: Int) {
        self.cityId = cityId
        super.init(nibName: nil, bundle: nil)
        setUpView()
        setUpConstraints()
        viewModel.observer = self
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchWeatherDetails(cityId: cityId)
        set(viewState: .loading)
    }

    private func setUpView() {
        view.addSubview(stackView)
        view.backgroundColor = Colors.primaryBackground
        topSafeAreaView.backgroundColor = Colors.tertiaryBackground
    }

    private func setUpConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-SafeAreaInsets.bottom)
        }
        topSafeAreaView.snp.makeConstraints { make in
            make.height.equalTo(SafeAreaInsets.top)
        }
        navigationBar.snp.makeConstraints { make in
            make.height.equalTo(NavigationBar.Layout.height)
        }
    }

    // MARK: State management

    private func set(viewState: WeatherDetailsViewState) {
        switch viewState {
        case .loading:
            setViewStateLoading()
        case .success:
            setViewStateSuccess()
        case .failure:
            setViewStateFailure()
        }
    }

    private func setViewStateLoading() {
        contentView.subviews.forEach({ subview in subview.removeFromSuperview() })
        contentView.showLoadingAnimation()
    }

    private func setViewStateSuccess() {
        let successView = WeatherDetailsView(cityName: viewModel.cityName,
                                             weatherConditionsImageName: viewModel.weatherConditionsImageName,
                                             weatherDescription: viewModel.weatherDescription,
                                             temperature: viewModel.temperature)
        contentView.subviews.forEach({ subview in subview.removeFromSuperview() })
        contentView.addSubview(successView)
        successView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setViewStateFailure() {
        let errorView = ErrorView(retryButtonAction: reload)
        contentView.subviews.forEach({ subview in subview.removeFromSuperview() })
        contentView.addSubview(errorView)
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: WeatherDetailsObserver

extension WeatherDetailsViewController: WeatherDetailsObserver {
    func didFetchWeatherDetails() {
        set(viewState: .success)
    }

    func didFail() {
        set(viewState: .failure)
    }
}

// MARK: Actions

private extension WeatherDetailsViewController {
    func dismiss() {
        dismiss(animated: true)
    }

    func reload() {
        viewModel.fetchWeatherDetails(cityId: cityId)
        set(viewState: .loading)
    }
}
