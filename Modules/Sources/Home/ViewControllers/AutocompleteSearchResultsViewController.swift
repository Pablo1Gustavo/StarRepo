import UIKit

protocol AutocompleteSearchResultsViewControllerDelegate: AnyObject {
    func didSelectLanguage(_ language: String)
}

class AutocompleteSearchResultsViewController: UIViewController {
    
    private var viewModel: AutocompleteSearchResultsViewModel
    
    weak var delegate: AutocompleteSearchResultsViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    
    init(viewModel: AutocompleteSearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    override func loadView() {
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
    
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Public methods
    
    func fetchLanguages(searchText: String) {
        viewModel.searchLanguages(searchText: searchText) { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension AutocompleteSearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.filteredLanguages?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = viewModel.searchText
            
            return cell
        case 1:
            guard let language = viewModel.filteredLanguages?[indexPath.row] else { return UITableViewCell() }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = language
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard !viewModel.searchText.isEmpty else { return }
            delegate?.didSelectLanguage(viewModel.searchText)
        case 1:
            guard let language = viewModel.filteredLanguages?[indexPath.row] else { return }
            delegate?.didSelectLanguage(language)
        default:
            break
        }
    }
    
}
