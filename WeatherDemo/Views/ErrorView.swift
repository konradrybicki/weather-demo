import SnapKit
import UIKit

final class ErrorView: UIView {
    struct Layout {
        static let mainStackViewSpacing: CGFloat = 25
        static let mainStackViewWidth = UIScreen.main.bounds.width*(3/5)
        static let mainStackViewMaxHeight = UIScreen.main.bounds.height/2
        static let retryButtonHeight = 35
        static let retryButtonHorizontalMargin = 40
    }

    private lazy var errorImageView: UIImageView? = {
        guard #available(iOS 13.0, *) else { return nil }
        let image = UIImage(systemName: "exclamationmark.triangle")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryContent
        return imageView
    }()

    private lazy var errorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = errorDescription
        label.font = .systemFont(ofSize: FontSizes.medium)
        label.textColor = Colors.primaryContent
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var retryButton = Button(title: "Retry", action: retryButtonAction)

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorDescriptionLabel, retryButton])
        errorImageView.map { view in stackView.insertArrangedSubview(view, at: 0) }
        stackView.axis = .vertical
        stackView.spacing = Layout.mainStackViewSpacing
        return stackView
    }()

    private let errorDescription: String
    private let retryButtonAction: ()->Void

    init(errorDescription: String = "An error occured.",
         retryButtonAction: @escaping ()->Void) {
        self.errorDescription = errorDescription
        self.retryButtonAction = retryButtonAction
        super.init(frame: .zero)
        addSubview(mainStackView)
        setUpConstraints()
    }

    required init?(coder: NSCoder) { nil }

    private func setUpConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(Layout.mainStackViewWidth)
            make.height.lessThanOrEqualTo(Layout.mainStackViewMaxHeight)
        }
        errorImageView?.snp.makeConstraints({ make in
            make.height.equalTo(GlobalLayout.largeImageSize)
        })
        retryButton.snp.makeConstraints { make in
            make.height.equalTo(Layout.retryButtonHeight)
            make.leading.equalToSuperview().offset(Layout.retryButtonHorizontalMargin)
            make.trailing.equalToSuperview().offset(-Layout.retryButtonHorizontalMargin)
        }
    }
}
