import UIKit
import Favorites
import FavoritesData
import Core
import RepoDetails
import SplitDetailView

final class FavoritesCoordinator: Coordinator {
    
    typealias UIViewControllerType = UISplitViewController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UISplitViewController
    
    init(rootViewController: UISplitViewController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        rootViewController.preferredDisplayMode = .oneBesideSecondary
        rootViewController.delegate = self
        
        // Master
        
        let viewModel = FavoritesListViewModel(
            fetchService: Persistence.shared,
            deleteService: Persistence.shared
        )
        
        let viewController = FavoritesListViewController(
            viewModel: viewModel,
            didSelectFavoriteRepository: { favRepositorie in
                self.pushRepoDetailsViewController(repository: favRepositorie)
            }
        )
        
        let masterViewController = UINavigationController(rootViewController: viewController)
        
        // Detail
        
        let detailViewModel = SplitDetailViewModel(
            initialMessage: "Select a Repository"
        )
        
        let detailViewController = SplitDetailViewController(
            viewModel: detailViewModel
        )
        
        rootViewController.viewControllers = [
            masterViewController,
            detailViewController
        ]
    }
    
    func pushRepoDetailsViewController(repository: FavRepo) {
        var secondaryViewController: UIViewController
        
        let viewModel = RepoDetailsViewModel(
            repoDetails: nil,
            favReference: repository,
            repoDetailsService: RepoDetailsService(),
            fetchFavReposService: Persistence(),
            addFavRepoService: Persistence(),
            deleteFavRepoService: Persistence()
        )
        
        let viewController = RepoDetailsViewController(
            viewModel: viewModel
        )
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            secondaryViewController = UINavigationController(rootViewController: viewController)
        } else {
            secondaryViewController = viewController
        }
        
        rootViewController.showDetailViewController(secondaryViewController, sender: nil)
    }
    
}

extension FavoritesCoordinator: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
