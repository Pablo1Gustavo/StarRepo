import UIKit
import Home
import Core
import RepoDetails
import SplitDetailView
import FavoritesData

final class HomeCoordinator: Coordinator {
    
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
        
        let viewModel = HomeViewModel(
            homeService: HomeService(),
            automcompleteService: HomeAutocompleteService()
        )
        
        let viewController = HomeViewController(
            viewModel: viewModel,
            didSelectRepository: { repo in
                self.pushRepoDetailsViewController(repository: repo)
            }
        )
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // Detail
        
        let detailViewModel = SplitDetailViewModel(
            initialMessage: "Select a Repository"
        )
        
        let detailViewController = SplitDetailViewController(
            viewModel: detailViewModel
        )
        
        rootViewController.viewControllers = [
            navigationController,
            detailViewController
        ]
    }
    
    func pushRepoDetailsViewController(repository: Repository) {
        var secondaryViewController: UIViewController
        
        let viewModel = RepoDetailsViewModel(
            repoDetails: repository,
            favReference: nil,
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

extension HomeCoordinator: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
