import Foundation
import Core

public protocol HomeServiceProtocol {
    func fetchRepositories(searchText: String, completion: @escaping (Result<[Repository], Error>) -> Void)
}

#if DEBUG
extension DummyHomeService {
    enum CustomError: Error {
        case generic
    }
}

struct DummyHomeService: HomeServiceProtocol {
    private var state: HomeViewModel.ViewState
    
    init(state: HomeViewModel.ViewState) {
        self.state = state
    }
    
    func fetchRepositories(searchText: String, completion: (Result<[Repository], Error>) -> Void) {
        switch state {
        case .done:
            let repos: [Repository] = [
                .init(
                    id: 1,
                    name: "Repo 1",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    owner: .init(
                        avatarURL: ""
                    ),
                    watchers: 0,
                    createdAt: "",
                    license: .init(
                        name: "MIT License",
                        url: ""
                    )
                ),
                .init(
                    id: 1,
                    name: "Repo 2",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    owner: .init(
                        avatarURL: ""
                    ),
                    watchers: 0,
                    createdAt: "",
                    license: .init(
                        name: "MIT License",
                        url: ""
                    )
                ),
                .init(
                    id: 2,
                    name: "Repo 3",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    owner: .init(
                        avatarURL: ""
                    ),
                    watchers: 0,
                    createdAt: "",
                    license: .init(
                        name: "MIT License",
                        url: ""
                    )
                )
            ]
            completion(.success(repos))
        case .empty:
            completion(.success([]))
        case .failure:
            completion(.failure(CustomError.generic))
        default:
            break
        }
    }
}
#endif
