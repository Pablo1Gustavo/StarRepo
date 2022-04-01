import UIKit
import Home
import Core

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
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemPink
        rootViewController.pushViewController(viewController, animated: true)
    }
}
