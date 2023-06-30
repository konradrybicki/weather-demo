import SnapKit
import UIKit

enum SearchViewState: Equatable {
    case none
    case success
    case failure
}

final class SearchView: UIView {
    private lazy var tableView = UITableView()
    private lazy var failureLabel: UILabel = {
        let label = UILabel()
        label.text = "No matching results."
        label.font = .systemFont(ofSize: FontSizes.medium)
        label.textColor = Colors.secondaryContent
        return label
    }()

    weak var dataSource: UITableViewDataSource? {
        get { tableView.dataSource }
        set { tableView.dataSource = newValue }
    }
    weak var delegate: UITableViewDelegate? {
        get { tableView.delegate }
        set { tableView.delegate = newValue }
    }

    init() {
        super.init(frame: .zero)
        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) { nil }

    // MARK: View setup

    private func setUpView() {
        addSubview(tableView)
        addSubview(failureLabel)
        tableView.isHidden = true
        failureLabel.isHidden = true
    }

    private func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        failureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    // MARK: State management

    func set(viewState: SearchViewState) {
        switch viewState {
        case .none:
            setViewStateNone()
        case .success:
            setViewStateSuccess()
        case .failure:
            setViewStateFailure()
        }
    }
}

private extension SearchView {
    func setViewStateNone() {
        tableView.isHidden = true
        failureLabel.isHidden = true
    }

    func setViewStateSuccess() {
        tableView.reloadData()
        tableView.isHidden = false
        failureLabel.isHidden = true
    }

    func setViewStateFailure() {
        tableView.isHidden = true
        failureLabel.isHidden = false
    }
}
