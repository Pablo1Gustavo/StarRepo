import Foundation

public protocol RepositoryProtocol {
    var id: NSNumber { get set }
    var imageURL: String? { get set }
    var name: String { get set }
    var desc: String? { get set }
}
