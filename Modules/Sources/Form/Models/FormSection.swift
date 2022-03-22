import Foundation

public struct FormSection {
    
    public var title: String?
    public var rows: [FormRowBase]
    
    public init(title: String? = nil, rows: [FormRowBase]) {
        self.title = title
        self.rows = rows
    }
    
}
