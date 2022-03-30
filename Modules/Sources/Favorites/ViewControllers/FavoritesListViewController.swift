import UIKit
import FavoritesData
import Core

public class FavoritesListViewController: UIViewController {

    private var viewModel: FavoritesListViewModel
    
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
    }
    
    // MARK: - Private methods
    
    // MARK: - Public methods

}
