import UIKit

struct SafeAreaInsets {
    static var top: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        } else {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        }
    }

    static var bottom: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        } else {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
    }
}
