import UIKit
import DeveloperTeamList
import DeveloperDetails
import Core
import SplitDetailView

final class DeveloperTeamCoordinator: Coordinator {
    
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
        
        let viewModel = DeveloperTeamListViewModel(
            developerListService: DeveloperTeamListService()
        )
        
        let viewController = DeveloperTeamListViewController(
            viewModel: viewModel,
            didSelectDeveloper: { developer in
                self.pushDeveloperDetails(developer: developer)
            }
        )
        
        let masterViewController = UINavigationController(rootViewController: viewController)
        
        // Detail
        
        let detailViewModel = SplitDetailViewModel(
            initialMessage: "Select a Developer"
        )
        
        let detailViewController = SplitDetailViewController(
            viewModel: detailViewModel
        )
        
        rootViewController.viewControllers = [
            masterViewController,
            detailViewController
        ]
    }
    
    func pushDeveloperDetails(developer: Developer) {
        let secondaryViewController: UIViewController
        
        let viewModel = DeveloperDetailsViewModel(
            developer: developer
        )
        
        let viewController = DeveloperDetailsViewController(
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

extension DeveloperTeamCoordinator: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
