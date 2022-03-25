import UIKit
import Home

final class HomeCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = HomeViewModel()
        
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.view.backgroundColor = .systemGray2
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
}
