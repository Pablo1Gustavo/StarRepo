import Foundation

public struct Repository: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    
    public init(id: Int, name: String, description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }
}
