import Foundation
import Core
import FavoritesData

public extension FavoritesListViewModel {
    enum State: String, CaseIterable {
        case done = "Done"
        case empty = "Empty"
        case failure = "Failure"
        case loading = "Loading"
    }
}

public final class FavoritesListViewModel {
    
    private(set) var state: State = .loading
    
    private(set) var favRepositories: [FavRepo] = []
    
    public init() {
        
    }
    
    func fetchFavoriteRepos() {
        //state = .loading
        
        Persistence.shared.fetchFavoriteRepos() {result in
            switch result {
            case .success(let res):
                self.favRepositories = res
                self.state = res.isEmpty ? .empty : .done
            case .failure(let error):
                print(error)
                self.state = .failure
            }
        }
        
//        for item in favRepositories {
//            print(item.id!)
//        }
    }
    
    func deleteFavoriteRepo(id: UUID) {
        Persistence.shared.deleteFavoriteRepo(uuid: id) {result in
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
