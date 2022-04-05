import UIKit

extension TextRow {
    public final class Configuration: FormRowConfiguration {
//        public var textFont: UIFont = .preferredFont(for: .body, weight: .regular)
        public var textFont: UIFont = .preferredFont(forTextStyle: .body)
        public var textColor: UIColor = .label
    }
}

public struct TextRow: FormRow {
    
    public typealias RowConfigration = Configuration
    
    public var image: UIImage?
    public var text: String
    
    public var configuration: Configuration = Configuration()
    
    public var action: (() -> Void)?
    
    public init(
        image: UIImage? = nil,
        text: String,
        configurationHandler: ((inout RowConfigration) -> Void)? = nil,
        action: (() -> Void)? = nil
    ) {
        self.image = image
        self.text = text
        
        self.action = action
        
        configurationHandler?(&configuration)
    }
}
