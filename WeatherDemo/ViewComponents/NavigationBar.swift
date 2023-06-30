import SnapKit
import UIKit

final class NavigationBar: UIView {
    public struct Layout {
        static let height = 55
        static let cancelButtonSize = 25
    }

    private lazy var navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSizes.small)
        label.text = navigationTitle
        label.textColor = Colors.primaryContent
        return label
    }()

    private lazy var cancelButton = CancelButton(action: cancelButtonAction)

    private let navigationTitle: String
    private let cancelButtonAction: ()->Void

    init(navigationTitle: String, cancelButtonAction: @escaping ()->Void) {
        self.navigationTitle = navigationTitle
        self.cancelButtonAction = cancelButtonAction
        super.init(frame: .zero)
        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) { nil }

    private func setUpView() {
        addSubview(navigationTitleLabel)
        addSubview(cancelButton)
        backgroundColor = Colors.tertiaryBackground
    }

    private func setUpConstraints() {
        navigationTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(Layout.cancelButtonSize)
            make.height.equalTo(Layout.cancelButtonSize)
            make.leading.equalToSuperview().offset(GlobalLayout.horizontalMargin)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: Selectors

@objc
private extension NavigationBar {
    func cancelButtonTapped() {
        cancelButtonAction()
    }
}
