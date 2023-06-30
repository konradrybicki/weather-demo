import UIKit

// MARK: Adaptable

struct Colors {
    static var primaryContent: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }

    static var secondaryContent: UIColor {
        if #available(iOS 13.0, *) {
            return .tertiaryLabel
        } else {
            return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }

    static var primaryBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }

    static var secondaryBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .secondarySystemFill
        } else {
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }

    static var tertiaryBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .tertiarySystemFill
        } else {
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}

// MARK: Fixed

extension Colors {
    @inlinable static var peterRiver: UIColor { #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1) }
}
