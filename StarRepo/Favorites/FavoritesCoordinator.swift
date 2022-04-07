import UIKit
import Favorites
import FavoritesData
import Core
import RepoDetails

final class FavoritesCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = FavoritesListViewModel(fetchService: Persistence.shared, deleteService: Persistence.shared)
        
        let viewController = FavoritesListViewController(
            viewModel: viewModel,
            didSelectFavoriteRepository: { favRepositorie in
                self.pushRepoDetailsViewController(repository: favRepositorie)
            }
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
    func pushRepoDetailsViewController(repository: FavRepo) {
        let viewModel = RepoDetailsViewModel(
            repoDetails: nil,
            favReference: repository,
            repoDetailsService: RepoDetailsService(),
            fetchFavReposService: Persistence(),
            addFavRepoService: Persistence(),
            deleteFavRepoService: Persistence()
        )
        
        let viewController = RepoDetailsViewController(viewModel: viewModel)
        //viewController.view.backgroundColor = .systemPink
        rootViewController.pushViewController(viewController, animated: true)
    }
    
}
