import Foundation
import Core
import FavoritesData

public extension FavoritesListViewModel {
    enum ViewState: String, CaseIterable {
        case done = "Done"
        case empty = "Empty"
        case failure = "Failure"
        case loading = "Loading"
    }
}

public final class FavoritesListViewModel {
    
    private var fetchService: FetchFavoriteReposProtocol
    
    private var deleteService: DeleteFavoriteRepoProtocol
    
    public var didUpdateViewState: (() -> Void)?
    
    private(set) var state: ViewState = .empty {
        didSet {
            didUpdateViewState?()
        }
    }
    
    var favRepositories: [FavRepo] = []
    
    public init(fetchService: FetchFavoriteReposProtocol, deleteService: DeleteFavoriteRepoProtocol) {
        self.fetchService = fetchService
        self.deleteService = deleteService
    }
    
    func fetchFavoriteRepos() {
        self.state = .loading
        
        fetchService.fetchFavoriteRepos {result in
            switch result {
            case .success(let favRepos):
                self.favRepositories = favRepos
                self.state = favRepos.isEmpty ? .empty : .done
            case .failure(let error):
                print(error)
                self.state = .failure
            }
        }
    }
    
    func deleteFavoriteRepo(id: Int64) {
        deleteService.deleteFavoriteRepo(id: id) {result in
            switch result {
            case .success(let res):
                print(res)
            case .failure(let error):
                print(error)
                self.state = .failure
            }
        }
    }
}
