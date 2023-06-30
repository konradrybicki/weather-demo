import SnapKit
import UIKit

final class SearchTextField: UIView {
    struct Layout {
        static let cornerRadius: CGFloat = 10
        static let horizontalMargin: CGFloat = 12
        static let verticalMargin: CGFloat = 6
    }

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.secondaryBackground
        view.layer.cornerRadius = Layout.cornerRadius
        return view
    }()

    private lazy var magnifierImageView: UIImageView? = {
        guard #available(iOS 13.0, *) else { return nil }
        let image = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .tertiaryLabel
        return imageView
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: FontSizes.medium)
        field.placeholder = placeholder
        field.inputAccessoryView = toolbar
        field.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return field
    }()

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [space, doneButton]
        toolbar.sizeToFit()
        return toolbar
    }()

    private lazy var stackView: UIStackView? = {
        guard let magnifierImageView = magnifierImageView else { return nil }
        let stackView = UIStackView(arrangedSubviews: [magnifierImageView, textField])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    weak var delegate: TextFieldDelegate? {
        get { textField.delegate as? TextFieldDelegate }
        set { textField.delegate = newValue }
    }

    private let placeholder: String

    init(placeholder: String) {
        self.placeholder = placeholder
        super.init(frame: .zero)
        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) { nil }

    private func setUpView() {
        if #available(iOS 13.0, *) {
            guard let stackView = stackView else { return }
            addSubview(background)
            addSubview(stackView)
        } else {
            addSubview(background)
            addSubview(textField)
        }
    }

    private func setUpConstraints() {
        if #available(iOS 13.0, *) {
            setUpBackgroundConstraints()
            setUpStackViewConstraints()
        } else {
            setUpBackgroundConstraints()
            setUpTextFieldConstraints()
        }
    }
}

// MARK: Constraints

private extension SearchTextField {
    func setUpBackgroundConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setUpStackViewConstraints() {
        guard let stackView = stackView else { return }
        guard let magnifierImageView = magnifierImageView else { return }
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.horizontalMargin)
            make.trailing.equalToSuperview().offset(-Layout.horizontalMargin)
            make.top.equalToSuperview().offset(Layout.verticalMargin)
            make.bottom.equalToSuperview().offset(-Layout.verticalMargin)
        }
        magnifierImageView.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
    }

    func setUpTextFieldConstraints() {
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.horizontalMargin)
            make.trailing.equalToSuperview().offset(-Layout.horizontalMargin)
            make.top.equalToSuperview().offset(Layout.verticalMargin)
            make.bottom.equalToSuperview().offset(-Layout.verticalMargin)
        }
    }
}

// MARK: Selectors

@objc
private extension SearchTextField {
    func doneButtonTapped() {
        textField.endEditing(true)
    }

    func textFieldEditingChanged() {
        delegate?.textFieldDidChangeEditing(textField)
    }
}
