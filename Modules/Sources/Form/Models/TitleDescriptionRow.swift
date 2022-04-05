import UIKit

extension TitleDescriptionRow {
    public final class Configuration: FormRowConfiguration {
//        public var titleFont: UIFont = .preferredFont(for: .body, weight: .semibold)
        public var titleFont: UIFont = .preferredFont(forTextStyle: .body)
        public var titleTextColor: UIColor = .label
//        public var descriptionFont: UIFont = .preferredFont(for: .body, weight: .regular)
        public var descriptionFont: UIFont = .preferredFont(forTextStyle: .body)
        public var descriptionTextColor: UIColor = .label
    }
}

public struct TitleDescriptionRow: FormRow {
    
    public typealias RowConfigration = Configuration
    
    public var image: UIImage?
    public var title: String
    public var description: String
    
    public var configuration: Configuration = Configuration()
    
    public var action: (() -> Void)?
    
    public init(
        image: UIImage? = nil,
        title: String,
        description: String,
        configurationHandler: ((inout RowConfigration) -> Void)? = nil,
        action: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.description = description
        self.action = action
        
        configurationHandler?(&configuration)
    }
    
}
