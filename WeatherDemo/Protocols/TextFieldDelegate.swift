import UIKit

protocol TextFieldDelegate: UITextFieldDelegate {
    func textFieldDidChangeEditing(_ textField: UITextField)
}
