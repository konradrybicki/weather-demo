import SnapKit
import UIKit

final class RecentsView: UIView {
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No recent searches."
        label.font = .systemFont(ofSize: FontSizes.medium)
        label.textColor = Colors.secondaryContent
        return label
    }()

    init() {
        super.init(frame: .zero)
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) { nil }
}
