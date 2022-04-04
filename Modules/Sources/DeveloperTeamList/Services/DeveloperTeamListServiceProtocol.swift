import Foundation
import Core

public protocol DeveloperTeamListServiceProtocol {
    func fetchDevelopers(_ completion: @escaping (Result<[Developer], Error>) -> Void)
}

#if DEBUG
struct DummyDeveloperTeamListService: DeveloperTeamListServiceProtocol {
    func fetchDevelopers(_ completion: @escaping (Result<[Developer], Error>) -> Void) {
        let devs: [Developer] = [
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
        completion(.success(devs))
    }
}
#endif
