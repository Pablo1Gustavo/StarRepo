import Foundation

public protocol FormDelegate: AnyObject {
    func buidSections() -> [FormSection]
}
