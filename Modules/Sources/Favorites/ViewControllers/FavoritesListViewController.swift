import UIKit
import FavoritesData
import Core

public class FavoritesListViewController: UIViewController {

    private var viewModel: FavoritesListViewModel
    
    var favRepoList: [FavRepo] = []
    
    // MARK: - Initializers
    
    public init(viewModel: FavoritesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        title = "Favorites"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
    // MARK: - Public methods

#if DEBUG
import SwiftUI

struct FavoritesListViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ContainerPreview()
                .ignoresSafeArea()
        } else {
            ContainerPreview()
                .environment(\.colorScheme, .dark)
        }
    }
    
    struct ContainerPreview: UIViewControllerRepresentable {
        typealias UIViewControllerType = UINavigationController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewModel = FavoritesListViewModel()
            
            let viewController = FavoritesListViewController(
                viewModel: viewModel
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
