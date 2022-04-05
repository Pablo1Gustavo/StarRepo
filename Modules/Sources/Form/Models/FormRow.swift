import UIKit

public protocol FormRowBase {}

public protocol FormRow: FormRowBase {
    associatedtype RowConfigration: FormRowConfiguration
    
    var image: UIImage? { get set }
    
    var configuration: RowConfigration { get set }
    
    var action: (() -> Void)? { get set }
}

public class FormRowConfiguration {
    public var tintColor: UIColor = .systemBlue
}
