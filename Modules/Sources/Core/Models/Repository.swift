import Foundation

public struct Repository: Decodable, RepositoryProtocol {
    @SRNumber public var id: NSNumber
    public var name: String
    public var desc: String?
    public let owner: Owner?
    public let watchers: Int
    public let createdAt: String
    public let license: License?
    public let url: String
    
    public var imageURL: String? {
        get {
            return owner?.avatarURL
        } set {}
    }
    
    public init(
        id: NSNumber,
        name: String,
        description: String,
        owner: Owner?,
        watchers: Int,
        createdAt: String,
        license: License?,
        url: String
    ) {
        self.id = id
        self.name = name
        self.desc = description
        self.owner = owner
        self.watchers = watchers
        self.createdAt = createdAt
        self.license = license
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case owner
        case watchers
        case createdAt = "created_at"
        case license
        case url = "html_url"
    }
}

public struct Owner: Decodable {
    public let avatarURL: String?
    public let login: String
    
    public init(avatarURL: String, login: String) {
        self.avatarURL = avatarURL
        self.login = login
    }
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case login
    }
}

public struct License: Codable {
    public let name: String?
    public let url: String?
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

#if DEBUG
public extension Repository {
    static var debugRepositories: [Repository] {
        return [
            .init(
                id: 1,
                name: "Repo 1",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                owner: .init(
                    avatarURL: "",
                    login: "login"
                ),
                watchers: 0,
                createdAt: "",
                license: .init(
                    name: "MIT License",
                    url: ""
                ),
                url: "https://www.github.com/"
            ),
            .init(
                id: 1,
                name: "Repo 2",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                owner: .init(
                    avatarURL: "",
                    login: "login"
                ),
                watchers: 0,
                createdAt: "",
                license: .init(
                    name: "MIT License",
                    url: ""
                ),
                url: "https://www.github.com/"
            ),
            .init(
                id: 2,
                name: "Repo 3",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                owner: .init(
                    avatarURL: "",
                    login: "login"
                ),
                watchers: 0,
                createdAt: "",
                license: .init(
                    name: "MIT License",
                    url: ""
                ),
                url: "https://www.github.com/"
            )
        ]
    }
}
#endif
