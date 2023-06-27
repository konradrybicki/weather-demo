import SnapKit
import UIKit

enum HomeScreenViewState {
    case homeScreen
    case searchView
}

final class HomeScreenViewController: UIViewController {
    struct Constants {
        static let titleText = "Weather"
        static let searchFieldPlaceholderText = "Search for city"
        static let stackViewSpacing = 10
        static let animationsDuration = 0.2 // (seconds)
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleText
        label.font = .boldSystemFont(ofSize: FontSizes.large)
        return label
    }()
    private lazy var searchTextField = SearchTextField(placeholder: Constants.searchFieldPlaceholderText)
    private lazy var recentsView = RecentsView()
    private lazy var searchView = SearchView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, searchTextField, recentsView, searchView])
        stackView.axis = .vertical
        stackView.spacing = CGFloat(integerLiteral: Constants.stackViewSpacing)
        return stackView
    }()

    private lazy var cityList = CityListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpDependencies()
    }

    // MARK: View setup

    private func setUpView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(GlobalLayout.horizontalMargin)
            make.trailing.equalToSuperview().offset(-GlobalLayout.horizontalMargin)
            make.top.equalToSuperview().offset(GlobalLayout.bigTopMargin)
            make.bottom.equalToSuperview().offset(-GlobalLayout.bottomMargin)
        }
        set(viewState: .homeScreen)
    }

    private func setUpDependencies() {
        searchTextField.delegate = self
        searchView.dataSource = self
        searchView.delegate = self
        cityList.observer = self
    }

    // MARK: State management

    private func set(viewState: HomeScreenViewState) {
        switch viewState {
        case .homeScreen:
            setViewStateHomeScreen()
        case .searchView:
            setViewStateSearchView()
        }
    }

    private func setViewStateHomeScreen() {
        UIView.animate(withDuration: Constants.animationsDuration) { [weak self] in
            self?.titleLabel.isHidden = false
            self?.recentsView.isHidden = false
            self?.searchView.isHidden = true
        }
    }

    private func setViewStateSearchView() {
        UIView.animate(withDuration: Constants.animationsDuration) { [weak self] in
            self?.titleLabel.isHidden = true
            self?.recentsView.isHidden = true
            self?.searchView.isHidden = false
        }
    }
}

// MARK: TextFieldDelegate

extension HomeScreenViewController: TextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        set(viewState: .searchView)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        set(viewState: .homeScreen)
        textField.text = .empty()
        searchView.set(viewState: .none)
    }

    func textFieldDidChangeEditing(_ textField: UITextField) {
        searchView.set(viewState: .none)
        guard let regex = try? NSRegularExpression(pattern: Strings.cityTextRegex) else { return }
        guard let text = textField.text?.lowercased(), text.matches(regex) else { return }
        cityList.getCities(byPrefix: text)
    }
}

// MARK: CityListObserver

extension HomeScreenViewController: CityListObserver {
    func cityListDidUpdate(_ cityList: [CityViewModel]) {
        searchView.set(viewState: !cityList.isEmpty ? .success : .failure)
    }
}

// MARK: TableView (SearchView)

extension HomeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let city = cityList.cities[indexPath.row]
        cell.textLabel?.text = city.displayName
        return cell
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
