import UIKit
import FavoritesData
import CoreUI
import Extensions
import Core

public class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel
    
    public var didSelectRepository: (Repository) -> Void
    
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
    
    private lazy var autocompleteSearchResultsController: AutocompleteSearchResultsViewController = {
        let controller = AutocompleteSearchResultsViewController(
            viewModel: AutocompleteSearchResultsViewModel()
        )
        controller.delegate = self
        return controller
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: autocompleteSearchResultsController)
        searchController.searchBar.placeholder = "Search for repos by language..."
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    // MARK: - Initializers
    
    public init(viewModel: HomeViewModel, didSelectRepository: @escaping (Repository) -> Void) {
        self.viewModel = viewModel
        self.didSelectRepository = didSelectRepository
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
        
        reloadView()
        viewModel.didUpdateViewState = { [weak self] in
            DispatchQueue.main.async {
                self?.reloadView()
            }
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.deselectRow(animated: true)
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
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func registerCells() {
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        
    }
    
    private func searchRepositories(language: String) {
        viewModel.fetchRepos(searchText: language)
    }
    
    private func reloadView() {
        tableView.reloadData()
        
        switch viewModel.state {
        case .onboarding:
            emptyMessageLabel.text = "Onboarding"
            tableView.backgroundView = emptyMessageLabel
        case .loading:
            emptyMessageLabel.text = "Loading"
            tableView.backgroundView = emptyMessageLabel
        case .done:
            emptyMessageLabel.text = nil
            tableView.backgroundView = nil
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

extension HomeViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let resultsController = searchController.searchResultsController as? AutocompleteSearchResultsViewController else {
            return
        }
        
        guard let searchText = searchController.searchBar.text else { return }
        
        resultsController.fetchLanguages(searchText: searchText)
    }
}

extension HomeViewController: AutocompleteSearchResultsViewControllerDelegate {
    func didSelectLanguage(_ language: String) {
        searchController.isActive = false
        searchController.searchBar.text = language
        searchRepositories(language: language)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state == .done ? viewModel.repositories.count : 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        let repo = viewModel.repositories[indexPath.row]
        cell.configure(with: repo)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.repositories[indexPath.row]
        didSelectRepository(repo)
    }
    
}

#if DEBUG
import SwiftUI

struct HomeViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(HomeViewModel.ViewState.allCases, id: \.self) { state in
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
        
        private var state: HomeViewModel.ViewState
        
        init(state: HomeViewModel.ViewState = .done) {
            self.state = state
        }
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewModel = HomeViewModel(
                homeService: DummyHomeService(
                    state: state
                )
            )
            
            let viewController = HomeViewController(
                viewModel: viewModel,
                didSelectRepository: { _ in }
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
