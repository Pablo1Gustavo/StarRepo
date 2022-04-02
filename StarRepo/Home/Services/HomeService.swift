import Foundation
import Core
import Home

struct HomeService: HomeServiceProtocol {
    
    func fetchRepositories(searchText: String, completion: (Result<[Repository], Error>) -> Void) {
        let repos: [Repository] = [
            .init(
                id: 0,
                name: "Teste",
                description: "Teste",
                owner: .init(avatarURL: ""),
                watchers: 0,
                createdAt: "",
                license: .init(
                    name: "MIT License",
                    url: ""
                )
            )
        ]
        completion(.success(repos))
    }
    
}
