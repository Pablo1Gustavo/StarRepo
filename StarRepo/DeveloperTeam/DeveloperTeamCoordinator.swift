import UIKit
import DeveloperTeamList
import DeveloperDetails
import Core

final class DeveloperTeamCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = DeveloperTeamListViewModel(
            developerListService: DeveloperTeamListService()
        )
        
        let viewController = DeveloperTeamListViewController(
            viewModel: viewModel,
            didSelectDeveloper: { developer in
                self.pushDeveloperDetails(developer: developer)
            }
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
    func pushDeveloperDetails(developer: Developer) {
        let viewModel = DeveloperDetailsViewModel(
            developer: developer
        )
        
        let viewController = DeveloperDetailsViewController(
            viewModel: viewModel
        )
        
        rootViewController.pushViewController(viewController, animated: true)
    }
}
