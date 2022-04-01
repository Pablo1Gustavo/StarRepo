import Foundation
import Core

public extension HomeViewModel {
    enum ViewState: String, CaseIterable {
        case done = "Done"
        case empty = "Empty"
        case failure = "Failure"
        case onboarding = "Onboarding"
        case loading = "Loading"
    }
}

public final class HomeViewModel {
    
    private var homeService: HomeServiceProtocol
    
    public var didUpdateViewState: (() -> Void)?
    private(set) var state: ViewState = .onboarding {
        didSet {
            didUpdateViewState?()
        }
    }
    
    private(set) var repositories: [Repository] = []
    
    public init(homeService: HomeServiceProtocol) {
        self.homeService = homeService
    }
    
    func fetchRepos(searchText: String) {
        state = .loading
        
        homeService.fetchRepositories(searchText: searchText) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repositories = repos
                self?.state = repos.isEmpty ? .empty : .done
            case .failure(let error):
                print(error.localizedDescription)
                self?.state = .failure
            }
        }
    }
    
}
