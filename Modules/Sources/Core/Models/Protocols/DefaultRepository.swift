import Foundation

public protocol DefaultRepository {
    var desc: String? { get set }
    var id: NSNumber? { get set }
    var imageURL: String? { get set }
    var title: String? { get set }
}
