import Foundation
import Core

public extension HomeViewModel {
    enum State: String, CaseIterable {
        case done = "Done"
        case empty = "Empty"
        case failure = "Failure"
        case loading = "Loading"
    }
}

public final class HomeViewModel {
    
    private var homeService: HomeServiceProtocol
    
    private(set) var state: State = .loading
    
    private(set) var repositories: [Repository] = []
    
    public init(homeService: HomeServiceProtocol) {
        self.homeService = homeService
    }
    
    func fetchRepos(searchText: String, completion: @escaping () -> Void) {
        state = .loading
        
        homeService.fetchRepositories(searchText: searchText) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repositories = repos
                self?.state = repos.isEmpty ? .empty : .done
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                self?.state = .failure
                completion()
            }
        }
    }
    
}
