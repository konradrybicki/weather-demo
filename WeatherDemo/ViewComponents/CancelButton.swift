import UIKit

final class CancelButton: UIButton {
    let action: ()->Void

    init(action: @escaping ()->Void) {
        self.action = action
        super.init(frame: .zero)
        setUpView()
        setUpAction()
    }

    required init?(coder: NSCoder) { nil }

    // MARK: View

    func setUpView() {
        if #available(iOS 13.0, *) {
            setUpWithImage()
        } else {
            setUpWithText()
        }
    }

    @available(iOS 13.0, *)
    private func setUpWithImage() {
        let image = UIImage(systemName: "xmark.app.fill")
        setBackgroundImage(image, for: .normal)
        tintColor = Colors.primaryContent
    }

    private func setUpWithText() {
        setTitle("Cancel", for: .normal)
        setTitleColor(Colors.primaryContent, for: .normal)
        titleLabel?.font = .systemFont(ofSize: FontSizes.small)
    }

    // MARK: Action

    private func setUpAction() {
        addTarget(self, action: #selector(gotTapped), for: .touchUpInside)
    }

    @objc
    private func gotTapped() {
        action()
    }
}
