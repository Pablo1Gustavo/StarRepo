import UIKit
import DeveloperTeamList

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
            viewModel: viewModel
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
}
