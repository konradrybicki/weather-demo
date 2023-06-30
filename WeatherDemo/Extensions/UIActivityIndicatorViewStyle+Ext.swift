import UIKit

extension UIActivityIndicatorView.Style {
    static func large() -> Self {
        if #available(iOS 13.0, *) {
            return .large
        } else {
            return .whiteLarge
        }
    }
}
