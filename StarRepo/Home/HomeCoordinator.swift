import UIKit
import Home
import Core
import RepoDetails

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
        let viewModel = RepoDetailsViewModel(repository: repository)
        let viewController = RepoDetailsViewController(viewModel: viewModel)
        rootViewController.pushViewController(viewController, animated: true)
    }
}
