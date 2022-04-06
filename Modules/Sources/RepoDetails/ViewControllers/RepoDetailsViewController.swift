import UIKit
import Form
import Core
import Extensions
import Kingfisher

public class RepoDetailsViewController: FormViewController{
    
    private var viewModel: RepoDetailsViewModel
    
    private var sections: [FormSection] = []
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableHeaderView: UIView = {
        let view = UIView()
        view.frame.size.height = 152
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    // MARK: - Initializers
    
    public init(viewModel: RepoDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        configureNavigationBar()
        configureTableHeaderView()
        
        configure(with: viewModel.repository)
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureTableHeaderView() {
        
        tableHeaderView.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 16),
            thumbnailImageView.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -16),
            thumbnailImageView.centerXAnchor.constraint(equalTo: tableHeaderView.centerXAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        tableView.tableHeaderView = tableHeaderView
        
    }
    
    private func configure(with model: Repository) {
        title = model.name
        if let urlString = model.owner?.avatarURL, let url = URL(string: urlString) {
            thumbnailImageView.kf.setImage(with: url)
        }
        let symbolConfiguration = UIImage.SymbolConfiguration(
            font: .preferredFont(for: .title3, weight: .medium)
        )
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        sections = [
            FormSection(
                title: nil,
                rows: [
                    TextRow(
                        text: model.desc ?? "No description",
                        configurationHandler: {
                            if model.desc == nil {
                                $0.textColor = .secondaryLabel
                            }
                        }
                    )
                ]
            ),
            FormSection(
                title: nil,
                rows: [
                    TitleDescriptionRow(
                        image: .init(systemName: "person.crop.rectangle", withConfiguration: symbolConfiguration),
                        title: "Author",
                        description: model.owner?.login ?? "-"
                    ),
                    TitleDescriptionRow(
                        image: .init(systemName: "eye", withConfiguration: symbolConfiguration),
                        title: "Watchers",
                        description: "\(model.watchers) watcher(s)"
                    ),
                    TitleDescriptionRow(
                        image: .init(systemName: "alarm.fill", withConfiguration: symbolConfiguration),
                        title: "Created at",
                        description: model.createdAt
                    ),
                    TitleDescriptionRow(
                        image: .init(systemName: "globe", withConfiguration: symbolConfiguration),
                        title: "License",
                        description: model.license?.name ?? "-"
                    )
                ]
            ),
            FormSection(
                title: nil,
                rows: [
                    ButtonRow(
                        image: nil,
                        title: "Go to Repository",
                        action: {[weak self] in
                            self?.performURL(for: model.url)
                        } )
                ]
            ),
        ]
    }
    
    private func performURL(for urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}

extension RepoDetailsViewController: FormDelegate {
    public func buidSections() -> [FormSection] {
        return sections
    }
}

#if DEBUG
import SwiftUI
import Core

struct RepoDetailsViewControllerPreviews: PreviewProvider {
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
            let viewModel = RepoDetailsViewModel(
                repository: Repository.debugRepositories[0]
            )
            
            let viewController = RepoDetailsViewController(
                viewModel: viewModel
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
