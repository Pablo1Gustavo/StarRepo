import Foundation

public struct Repository: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    public let owner: Owner
    public let watchers: Int
    public let createdAt: String
    public let license: License
    
    public init(id: Int, name: String, description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case owner
        case watchers
        case createdAt = "created_at"
        case license
    }
}

public struct Owner {
    public let login: String
    public let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}

public struct License {
    public let name
}
