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

#if DEBUG
public extension Developer {
    
    static var debugDevelopers: [Developer] {
        return [
            .init(
                id: 0,
                name: "Joshua D Jackson",
                aboutMe: "My woman is basking in the glow of my majestic presence=My woman is enjoying the shade provided by my enormous belly.",
                occupation: "Occupation 1",
                profileImageURL: "https://www.fakepersongenerator.com/Face/male/male108553451453.jpg",
                email: "walker1988@yahoo.com",
                phoneNumber: "918-459-6142",
                social: .init(
                    linkedinURL: "https://",
                    githubURL: "https://",
                    twitterURL: nil
                )
            ),
            .init(
                id: 0,
                name: "Tammy E Cardenas",
                aboutMe: "When people in life do you wrong, envision a dog with worms that just took a huge crap rubbing its butt all over their carpet.  May not fix the situation, but it will make you laugh a little inside.",
                occupation: "Occupation 2",
                profileImageURL: "https://www.fakepersongenerator.com/Face/female/female20171026316921508.jpg",
                email: "liliana_connel@gmail.com",
                phoneNumber: "475-227-0343",
                social: .init(
                    linkedinURL: "https://",
                    githubURL: "https://",
                    twitterURL: nil
                )
            )
        ]
    }
    
}
#endif
