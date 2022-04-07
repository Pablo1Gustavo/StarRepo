import UIKit
import Home
import Core
import RepoDetails
import FavoritesData

final class HomeCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = HomeViewModel(
            homeService: HomeService()
        )
        
        let viewController = HomeViewController(
            viewModel: viewModel,
            didSelectRepository: { repo in
                self.pushRepoDetailsViewController(repository: repo)
            }
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
    func pushRepoDetailsViewController(repository: Repository) {
        let viewModel = RepoDetailsViewModel(
            repoDetails: repository,
            favReference: nil,
            repoDetailsService: RepoDetailsService(),
            fetchFavReposService: Persistence(),
            addFavRepoService: Persistence(),
            deleteFavRepoService: Persistence()
        )
        let viewController = RepoDetailsViewController(viewModel: viewModel)
        rootViewController.pushViewController(viewController, animated: true)
    }
}
