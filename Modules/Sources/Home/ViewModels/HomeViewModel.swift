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
    private(set) var automcompleteService: HomeAutomcompleteServiceProtocol
    
    public var didUpdateViewState: (() -> Void)?
    private(set) var state: ViewState = .onboarding {
        didSet {
            didUpdateViewState?()
        }
    }
    
    private(set) var sortMode: SortMode = .descending
    
    private(set) var repositories: [Repository] = []
    
    public init(
        homeService: HomeServiceProtocol,
        automcompleteService: HomeAutomcompleteServiceProtocol
    ) {
        self.homeService = homeService
        self.automcompleteService = automcompleteService
    }
    
    func fetchRepos(searchText: String?, sortMode: SortMode) {
        repositories = []
        
        self.sortMode = sortMode
        
        if let searchText = searchText, !searchText.isEmpty {
            state = .loading
            
            homeService.fetchRepositories(searchText: searchText, sortMode: sortMode) { [weak self] result in
                switch result {
                case .success(let repos):
                    self?.repositories = repos
                    self?.state = repos.isEmpty ? .empty : .done
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.state = .failure
                }
            }
        } else {
            state = .onboarding
        }
    }
    
}
