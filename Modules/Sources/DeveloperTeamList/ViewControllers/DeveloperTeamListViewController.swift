import UIKit
import Extensions
import Core

public class DeveloperTeamListViewController: UIViewController {

    private var viewModel: DeveloperTeamListViewModel
    
    public var didSelectDeveloper: (Developer) -> Void
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    
    public init(
        viewModel: DeveloperTeamListViewModel,
        didSelectDeveloper: @escaping (Developer) -> Void
    ) {
        self.viewModel = viewModel
        self.didSelectDeveloper = didSelectDeveloper
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
        
        DispatchQueue.main.async {
            self.viewModel.fetchDevs { [weak self] in
                self?.tableView.reloadData()
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
        title = "Developers"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func registerCells() {
        
        tableView.register(DeveloperTableViewCell.self, forCellReuseIdentifier: DeveloperTableViewCell.identifier)
        
    }

}

extension DeveloperTeamListViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.developers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeveloperTableViewCell.identifier, for: indexPath) as? DeveloperTableViewCell else {
            return UITableViewCell()
        }
        
        let dev = viewModel.developers[indexPath.row]
        cell.configure(with: dev)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dev = viewModel.developers[indexPath.row]
        didSelectDeveloper(dev)
    }
    
}

#if DEBUG
import SwiftUI

struct DeveloperTeamListViewControllerPreviews: PreviewProvider {
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
            let viewModel = DeveloperTeamListViewModel(
                developerListService: DummyDeveloperTeamListService()
            )
            
            let viewController = DeveloperTeamListViewController(
                viewModel: viewModel,
                didSelectDeveloper: { _ in }
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
