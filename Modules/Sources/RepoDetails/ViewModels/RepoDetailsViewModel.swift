import Foundation
import Form
import Core
import FavoritesData

public extension RepoDetailsViewModel {
    enum ViewState: String, CaseIterable {
        case done = "Done"
        case failure = "Failure"
        case loading = "Loading"
    }
}

public final class RepoDetailsViewModel {
    
    // MARK: - Services
    
    private var repoDetailsService: RepoDetailsServiceProtocol
    
    private var fetchFavReposService: FetchFavoriteReposProtocol
    
    private var addFavRepoService: AddFavoriteRepoProtocol
    
    private var deleteFavRepoService: DeleteFavoriteRepoProtocol
    
    // MARK: - Private Variables
    
    private(set) var repoDetails: Repository?
    
    private(set) var favRepositories: [FavRepo] = []
    
    private(set) var favReference: FavRepo?
    
    private(set) var state: ViewState = .loading {
        didSet {
            didUpdateViewState?()
        }
    }
    
    //MARK: -Public Variables
    
    public var didUpdateViewState: (() -> Void)?
    
    //MARK: - Initializers
    
    public init(repoDetails: Repository?, favReference: FavRepo?, repoDetailsService: RepoDetailsServiceProtocol, fetchFavReposService: FetchFavoriteReposProtocol, addFavRepoService: AddFavoriteRepoProtocol, deleteFavRepoService: DeleteFavoriteRepoProtocol) {
        self.repoDetails = repoDetails
        self.favReference = favReference
        
        self.fetchFavReposService = fetchFavReposService
        self.addFavRepoService = addFavRepoService
        self.deleteFavRepoService = deleteFavRepoService
        
        self.repoDetailsService = repoDetailsService
    }
    
    //MARK: - API Functions
    
    ///Get details about one repository in GitHub API according to its id
    func fetchRepoDetails() {
        
        guard let favRef = self.favReference else {
            state = .done
            return
        }
        
        state = .loading
        
        repoDetailsService.fetchRepositorieDetails(id: Int(truncating: favRef.id)) { [weak self] result in //verify if truncating can represent a problem
            switch result {
            case .success(let details):
                self?.repoDetails = details
                self?.state = .done
            case .failure(let error):
                print(error.localizedDescription)
                self?.state = .failure
            }
        }
    }
    
    //MARK: - CoreData Functions
    
    ///Get an array of favorites repositories
    func fetchFavoriteRepos() {
        self.state = .loading
        
        fetchFavReposService.fetchFavoriteRepos {result in
            switch result {
            case .success(let favRepos):
                self.favRepositories = favRepos
                self.state = .done
            case .failure(let error):
                print(error)
                self.state = .failure
            }
        }
    }
    
    ///Delete a repository from favorites database
    func deleteFavoriteRepo(id: Int64) {
        deleteFavRepoService.deleteFavoriteRepo(id: id) {result in
            switch result {
            case .success(let res):
                print(res)
            case .failure(let error):
                print(error)
                self.state = .failure
            }
        }
    }
    
    ///Add a repository in favorites database
    func addFavoriteRepo(_ repo: Repository) {
        addFavRepoService.addFavoriteRepo(
            id: repo.id,
            name: repo.name,
            desc: repo.desc ?? "This repository does not have a description",
            imageURL: repo.imageURL ?? ""
        )
    }
}
