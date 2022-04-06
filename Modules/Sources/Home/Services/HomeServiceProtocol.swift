import Foundation
import Core

public protocol HomeServiceProtocol {
    func fetchRepositories(searchText: String, sortMode: SortMode, completion: @escaping (Result<[Repository], Error>) -> Void)
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
    
    func fetchRepositories(searchText: String, sortMode: SortMode, completion: (Result<[Repository], Error>) -> Void) {
        switch state {
        case .done:
            let repos = Repository.debugRepositories.sorted(by: {
                sortMode == .ascending ? $0.name < $1.name : $0.name > $1.name
            })
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
