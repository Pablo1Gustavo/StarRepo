import UIKit
import Core
import FavoritesData
import CoreUI

public class FavoritesListViewController: UIViewController {
    
    private var viewModel: FavoritesListViewModel
    
    public var didSelectFavoriteRepository: (FavRepo) -> Void
    
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
    
    public init(viewModel: FavoritesListViewModel, didSelectFavoriteRepository: @escaping (FavRepo) -> Void) {
        self.viewModel = viewModel
        self.didSelectFavoriteRepository = didSelectFavoriteRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        registerCells()
        
        searchFavorites()
        
        reloadView()
        viewModel.didUpdateViewState = { [weak self] in
            DispatchQueue.main.async {
                self?.reloadView()
            }
        }
    }
    
    public override func loadView() {
        super.loadView()
        
        configureTableView()
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        title = "Favoritos"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func searchFavorites() {
        
        viewModel.fetchFavoriteRepos()
        
    }
    
    private func registerCells() {
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        
    }
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func reloadView() {
        
        tableView.reloadData()
        
        switch viewModel.state {
        case .loading:
            emptyMessageLabel.text = "Loading"
            tableView.backgroundView = emptyMessageLabel
        case .done:
            emptyMessageLabel.text = nil
            tableView.backgroundView = nil
        case .empty:
            emptyMessageLabel.text = "No Favorites Repos"
            tableView.backgroundView = emptyMessageLabel
        case .failure:
            emptyMessageLabel.text = "Error"
            tableView.backgroundView = emptyMessageLabel
        }
    }
    
    // MARK: - Public methods
    
}

extension FavoritesListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let favRepositorie = viewModel.favRepositories[indexPath.row]
        didSelectFavoriteRepository(favRepositorie)
        
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let favRepoToDelete = viewModel.favRepositories[indexPath.row]
            viewModel.deleteFavoriteRepo(id: favRepoToDelete.id!.int64Value)
            searchFavorites()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
}

extension FavoritesListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.state == .done ? viewModel.favRepositories.count : 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        //random id for testing
        let randomInt = Int.random(in: 0..<999999)
        
        let favRepositorie = viewModel.favRepositories[indexPath.row]
        
        //have to change this after finishing defaultRepository protocol
        let repo = Repository( id: randomInt, name: favRepositorie.title ?? "", description: favRepositorie.desc ?? "")
        
        cell.configure(with: repo)
        
        return cell
    }
}

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
            let viewModel = FavoritesListViewModel(fetchService: Persistence(), deleteService: Persistence())
            
            let viewController = FavoritesListViewController(
                viewModel: viewModel,
                didSelectFavoriteRepository: { _ in }
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
