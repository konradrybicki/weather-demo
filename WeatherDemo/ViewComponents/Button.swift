import SnapKit
import UIKit

final class Button: UIButton {
    let title: String
    let action: ()->Void

    init(title: String, action: @escaping ()->Void) {
        self.title = title
        self.action = action
        super.init(frame: .zero)
        setUpTitle()
        setUpBackground()
        addTarget(self, action: #selector(gotTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) { nil }

    // MARK: Setup

    private func setUpTitle() {
        titleLabel?.font = .boldSystemFont(ofSize: FontSizes.medium)
        setTitle(title, for: .normal)
        setTitleColor(Colors.primaryBackground, for: .normal)
    }

    private func setUpBackground() {
        backgroundColor = Colors.primaryContent
        layer.cornerRadius = 10
    }

    // MARK: Selector

    @objc
    private func gotTapped() {
        action()
    }
}
