import Foundation
import Core

public protocol HomeService {
    func fetchRepositories(searchText: String, completion: (Result<[Repository], Error>) -> Void)
}

#if DEBUG
extension DummyHomeService {
    enum CustomError: Error {
        case generic
    }
}

struct DummyHomeService: HomeService {
    private var state: HomeViewModel.State
    
    init(state: HomeViewModel.State) {
        self.state = state
    }
    
    func fetchRepositories(searchText: String, completion: (Result<[Repository], Error>) -> Void) {
        switch state {
        case .done:
            let repos: [Repository] = [
                .init(
                    id: 1,
                    name: "Repo 1",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                ),
                .init(
                    id: 1,
                    name: "Repo 2",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                ),
                .init(
                    id: 2,
                    name: "Repo 3",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
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
