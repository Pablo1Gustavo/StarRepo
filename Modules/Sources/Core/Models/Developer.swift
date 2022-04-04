import Foundation

public struct Developer: Codable {
    public let id: Int
    public let name: String
    public let aboutMe: String
    public let occupation: String
    public let profileImageURL: String
    public let email: String
    public let phoneNumber: String
    public let social: Social
    
    public init(
        id: Int,
        name: String,
        aboutMe: String,
        occupation: String,
        profileImageURL: String,
        email: String,
        phoneNumber: String,
        social: Social
    ) {
        self.id = id
        self.name = name
        self.aboutMe = aboutMe
        self.occupation = occupation
        self.profileImageURL = profileImageURL
        self.email = email
        self.phoneNumber = phoneNumber
        self.social = social
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case aboutMe = "about_me"
        case occupation
        case profileImageURL = "profile_image_url"
        case email
        case phoneNumber = "phone_number"
        case social
    }
}

public extension Developer {
    
    struct Social: Codable {
        public let linkedinURL: String
        public let githubURL: String
        public let twitterURL: String?
        
        public init(
            linkedinURL: String,
            githubURL: String,
            twitterURL: String?
        ) {
            self.linkedinURL = linkedinURL
            self.githubURL = githubURL
            self.twitterURL = twitterURL
        }
        
        enum CodingKeys: String, CodingKey {
            case linkedinURL = "linkedin_url"
            case githubURL = "github_url"
            case twitterURL = "twitter_url"
        }
    }
    
}
