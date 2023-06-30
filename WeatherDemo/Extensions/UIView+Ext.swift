import SnapKit
import UIKit

extension UIView {
    func showLoadingAnimation() {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large()
        spinner.color = Colors.primaryContent
        spinner.tag = 1
        
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        spinner.startAnimating()
    }

    func hideLoadingAnimation() {
        guard let spinner = viewWithTag(1) else { return }
        spinner.snp.removeConstraints()
        spinner.removeFromSuperview()
    }
}
