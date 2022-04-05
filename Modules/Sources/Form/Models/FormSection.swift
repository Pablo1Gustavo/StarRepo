import Foundation

public struct FormSection {
    
    public var title: String?
    public var footer: String?
    public var rows: [FormRowBase]
    
    public init(title: String? = nil, footer: String? = nil, rows: [FormRowBase]) {
        self.title = title
        self.footer = footer
        self.rows = rows
    }
    
}
