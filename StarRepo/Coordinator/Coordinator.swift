import UIKit

protocol CoordinatorBase {}

protocol Coordinator: CoordinatorBase {
    
    associatedtype UIViewControllerType: UIViewController
    
    var childCoordinator: [CoordinatorBase] { get set }
    var rootViewController: UIViewControllerType { get set }
    
    init(rootViewController: UIViewControllerType)
    func start()
    
}
