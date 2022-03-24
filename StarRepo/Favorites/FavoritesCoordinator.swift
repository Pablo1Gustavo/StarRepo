import UIKit

final class FavoritesCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemGray3
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
}
