import UIKit
import Core
import FavoritesData
import CoreUI

public class FavoritesListViewController: UIViewController {

    private var viewModel: FavoritesListViewModel
    
    //public var didSelectRepository: (Repository) -> Void //verificar se é necessário
    
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
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        
        registerCells()
        
        fetchFavorites()
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadView()
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        title = "Favorites"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchFavorites() {
        viewModel.fetchFavoriteRepos()
    }
    
    private func registerCells() {
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        
    }
    
    //Function just for testing
    private func printFavReposId() {
        for repo in viewModel.favRepositories {
            print(repo.id!.int64Value)
        }
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

extension FavoritesListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let favRepoToDelete = viewModel.favRepositories[indexPath.row]
            viewModel.deleteFavoriteRepo(id: favRepoToDelete.id!.int64Value)
            fetchFavorites()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
}

extension FavoritesListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favRepositories.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        let randomInt = Int.random(in: 0..<999999)
        
        let favRepositorie = viewModel.favRepositories[indexPath.row]
        
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
                viewModel: viewModel
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
