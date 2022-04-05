import UIKit

extension ButtonRow {
    public final class Configuration: FormRowConfiguration {
//        public var textFont: UIFont = .preferredFont(for: .body, weight: .regular)
        public var textFont: UIFont = .preferredFont(forTextStyle: .body)
    }
}

public struct ButtonRow: FormRow {
    
    public typealias RowConfigration = Configuration
    
    public var image: UIImage?
    public var title: String
    
    public var configuration: Configuration = Configuration()
    
    public var action: (() -> Void)?
    
    public init(
        image: UIImage? = nil,
        title: String,
        configurationHandler: ((inout RowConfigration) -> Void)? = nil,
        action: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        
        self.action = action
        
        configurationHandler?(&configuration)
    }
    
}
