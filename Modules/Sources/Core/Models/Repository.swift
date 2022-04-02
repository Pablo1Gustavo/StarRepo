import Foundation

public struct Repository: Decodable, RepositoryProtocol {
    @SRNumber public var id: NSNumber
    public var name: String
    public var desc: String?
    public let owner: Owner
    public let watchers: Int
    public let createdAt: String
    public let license: License
    
    public var imageURL: String {
        get {
            return owner.avatarURL
        } set {}
    }
    
    public init(
        id: NSNumber,
        name: String,
        description: String?,
        owner: Owner,
        watchers: Int,
        createdAt: String,
        license: License
    ) {
        self.id = id
        self.name = name
        self.desc = description
        self.owner = owner
        self.watchers = watchers
        self.createdAt = createdAt
        self.license = license
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc
        case owner
        case watchers
        case createdAt = "created_at"
        case license
    }
}

public struct Owner: Decodable {
    public let avatarURL: String
    
    public init(avatarURL: String) {
        self.avatarURL = avatarURL
    }
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}

public struct License: Codable {
    public let name: String
    public let url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
