import UIKit
import Favorites

final class FavoritesCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = FavoritesListViewModel()
        
        let viewController = FavoritesListViewController(
            viewModel: viewModel
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
}
