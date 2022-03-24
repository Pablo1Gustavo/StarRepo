import UIKit

final class AppContributorsCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemGray4
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
}
