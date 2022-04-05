import Foundation
import Core

public protocol DeveloperTeamListServiceProtocol {
    func fetchDevelopers(_ completion: @escaping (Result<[Developer], Error>) -> Void)
}

#if DEBUG
struct DummyDeveloperTeamListService: DeveloperTeamListServiceProtocol {
    func fetchDevelopers(_ completion: @escaping (Result<[Developer], Error>) -> Void) {
        let devs: [Developer] = Developer.debugDevelopers
        completion(.success(devs))
    }
}
#endif
