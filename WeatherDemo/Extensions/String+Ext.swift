import Foundation

extension String {
    func matches(_ regex: NSRegularExpression) -> Bool {
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, range: range) != nil
    }
}

extension String {
    @inlinable static func empty() -> Self { "" }
    @inlinable static func space() -> Self { " " }
}
