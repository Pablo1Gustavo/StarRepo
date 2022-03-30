import UIKit
import FavoritesData
import CoreUI
import Extensions

public class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .bold)
        label.textColor = .secondaryLabel
        label.text = "Empty Message"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    public init(viewModel: HomeViewModel) {
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
        registerCells()
        
        viewModel.fetchRepos(searchText: "") { [weak self] in
            self?.reloadView()
        }
    }
    
    public override func loadView() {
        super.loadView()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        title = "Repos"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func registerCells() {
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        
    }
    
    private func reloadView() {
        tableView.reloadData()
        
        switch viewModel.state {
        case .loading:
            emptyMessageLabel.text = "Loading"
            tableView.backgroundView = emptyMessageLabel
        case .done:
            break
        case .empty:
            emptyMessageLabel.text = "No repos"
            tableView.backgroundView = emptyMessageLabel
        case .failure:
            emptyMessageLabel.text = "Error"
            tableView.backgroundView = emptyMessageLabel
        }
    }
    
    // MARK: - Public methods

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        let repo = viewModel.repositories[indexPath.row]
        cell.configure(with: repo)
        
        return cell
    }
    
}

#if DEBUG
import SwiftUI

struct HomeViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(HomeViewModel.State.allCases, id: \.self) { state in
            if #available(iOS 14.0, *) {
                ContainerPreview(state: state)
                    .ignoresSafeArea()
                    .previewDisplayName(state.rawValue)
            } else {
                ContainerPreview(state: state)
                    .environment(\.colorScheme, .dark)
                    .previewDisplayName(state.rawValue)
            }
        }
    }
    
    struct ContainerPreview: UIViewControllerRepresentable {
        typealias UIViewControllerType = UINavigationController
        
        private var state: HomeViewModel.State
        
        init(state: HomeViewModel.State = .done) {
            self.state = state
        }
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewModel = HomeViewModel(
                homeService: DummyHomeService(
                    state: state
                )
            )
            
            let viewController = HomeViewController(
                viewModel: viewModel
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
