import UIKit

final class AppCoordinator: Coordinator {
    
    typealias UIViewControllerType = UITabBarController
    
    var childCoordinator: [CoordinatorBase] = []
    var rootViewController: UITabBarController
    
    init(rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(rootViewController: UISplitViewController())
        homeCoordinator.start()
        
        homeCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: .init(systemName: "house"),
            tag: 0
        )
        
        let favoritesCoordinator = FavoritesCoordinator(rootViewController: UINavigationController())
        favoritesCoordinator.start()
        
        favoritesCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: .init(systemName: "star"),
            tag: 1
        )
        
        let developerTeamCoordinator = DeveloperTeamCoordinator(rootViewController: UINavigationController())
        developerTeamCoordinator.start()
        
        developerTeamCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Contributors",
            image: .init(systemName: "person.3"),
            tag: 2
        )
        
        rootViewController.viewControllers = [
            homeCoordinator.rootViewController,
            favoritesCoordinator.rootViewController,
            developerTeamCoordinator.rootViewController
        ]
    }
    
}
