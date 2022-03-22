import UIKit

public class FormViewController: UIViewController {
    
    private var viewModel: FormViewModel
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    
    public init(viewModel: FormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        tableView.reloadData()
    }
    
    public override func loadView() {
        super.loadView()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Private methods
    
    private func registerCells() {
        
        tableView.register(TitleDescriptionRowTableViewCell.self, forCellReuseIdentifier: TitleDescriptionRowTableViewCell.identifier)
        tableView.register(TextRowTableViewCell.self, forCellReuseIdentifier: TextRowTableViewCell.identifier)
        tableView.register(ButtonRowTableViewCell.self, forCellReuseIdentifier: ButtonRowTableViewCell.identifier)
        
    }
    
    // MARK: - Public methods
    
    public func setSections(_ sections: [FormSection]) {
        viewModel.setSections(sections)
        tableView.reloadData()
    }
    
    public func insertSection(_ section: FormSection, at index: Int, animated: Bool = true) {
        viewModel.insertSection(section, at: index)
        tableView.insertSections(IndexSet(integer: index), with: animated ? .automatic : .none)
    }

}

extension FormViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.sections[indexPath.section].rows[indexPath.row]
        
        switch row.self {
        case let formRow where formRow is TitleDescriptionRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleDescriptionRowTableViewCell.identifier, for: indexPath) as? TitleDescriptionRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! TitleDescriptionRow)
            
            return cell
        case let formRow where formRow is TextRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextRowTableViewCell.identifier, for: indexPath) as? TextRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! TextRow)
            
            return cell
        case let formRow where formRow is ButtonRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonRowTableViewCell.identifier, for: indexPath) as? ButtonRowTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: formRow as! ButtonRow)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

#if DEBUG
import SwiftUI

struct HomeViewControllerPreviews: PreviewProvider {
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
            let viewModel = FormViewModel(
                sections: [
                    FormSection(
                        rows: [
                            TextRow(
                                image: .init(systemName: "globe"),
                                text: "Test"
                            )
                        ]
                    ),
                    FormSection(
                        title: "Section 1",
                        rows: [
                            TextRow(
                                image: .init(systemName: ""),
                                text: "Test"
                            )
                        ]
                    ),
                    FormSection(
                        title: "Actions",
                        rows: [
                            ButtonRow(
                                image: .init(systemName: "link"),
                                title: "Go To"
                            )
                        ]
                    ),
                    FormSection(
                        title: "Title Description",
                        rows: [
                            TitleDescriptionRow(
                                image: .init(systemName: "globe"),
                                title: "Title",
                                description: "Description"
                            ),
                            TitleDescriptionRow(
                                title: "Title",
                                description: "Description"
                            ),
                            TitleDescriptionRow(
                                title: "Title",
                                description: "Description",
                                configurationHandler: { config in
                                    config.titleTextColor = .systemGreen
                                    config.descriptionTextColor = .systemBrown
                                }
                            )
                        ]
                    )
                ]
            )
            
            let viewController = FormViewController(
                viewModel: viewModel
            )
            viewController.title = "Form"
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
