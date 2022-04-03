import UIKit
import Favorites
import FavoritesData
import Core

final class FavoritesCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = FavoritesListViewModel(fetchService: Persistence(), deleteService: Persistence())
        
        let viewController = FavoritesListViewController(
            viewModel: viewModel,
            didSelectFavoriteRepository: { favRepositorie in
                self.pushRepoDetailsViewController(repository: favRepositorie)
            }
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
    func pushRepoDetailsViewController(repository: FavRepo) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemPink
        rootViewController.pushViewController(viewController, animated: true)
    }
    
}
