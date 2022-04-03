import UIKit
import Form

public class RepoDetailsViewController: UIViewController {
    
    private var viewModel: RepoDetailsViewModel

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public init(viewModel: RepoDetailsViewModel) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
