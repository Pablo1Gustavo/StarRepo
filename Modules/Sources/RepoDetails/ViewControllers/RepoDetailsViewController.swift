import UIKit
import Form
import Core
import Extensions
import Kingfisher
import SkeletonView

public class RepoDetailsViewController: FormViewController{
    
    // MARK: - Private Variables
    
    private var viewModel: RepoDetailsViewModel
    
    private var sections: [FormSection] = []
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var starBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.tintColor = .systemPurple
        barButton.style = .plain
        
        barButton.target = self
        barButton.action = #selector(handleStarBarButton)
        return barButton
    }()
    
    private lazy var tableHeaderView: UIView = {
        let view = UIView()
        view.frame.size.height = 152
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    private lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .bold)
        label.textColor = .secondaryLabel
        label.text = "Empty Message"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureNavigationBar()
        configureTableHeaderView()
        
        reloadView()
        
        handleStateChange()
        
        handlePushFromHome()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchFavoriteRepos()
        
        viewModel.fetchRepoDetails()
        
        starBarButtonInitialState()
    }
    
    // MARK: - Initializers
    
    public init(viewModel: RepoDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
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
    
    private func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func handleStateChange() {
        viewModel.didUpdateViewState = { [weak self] in
            DispatchQueue.main.async {
                if let details = self?.viewModel.repoDetails {
                    self?.configure(with: details)
                }
                self?.reloadView()
            }
        }
    }
    
    private func handlePushFromHome() {
        guard let details = viewModel.repoDetails else { return }
        
        configure(with: details)
        navigationItem.rightBarButtonItem = starBarButton
    }
    
    private func starBarButtonInitialState() {
        if repoIsFavorite() {
            starBarButton.image = UIImage.init(systemName: "star.fill")
        } else {
            starBarButton.image = UIImage.init(systemName: "star")
        }
    }
    
    private func repoIsFavorite() -> Bool {
        for repo in viewModel.favRepositories {
            let apiId = self.viewModel.repoDetails?.id
            let favId = repo.id
            if favId == apiId {
                return true
            }
        }
        return false
    }
    
    @objc
    private func handleStarBarButton() {
        let starSymbol = starBarButton.image!.sfSymbolName!
        
        if starSymbol == "star" {
            starBarButton.image = UIImage.init(systemName: "star.fill")
            if let repository = viewModel.repoDetails {
                viewModel.addFavoriteRepo(repository)
            }
        } else {
            starBarButton.image = UIImage.init(systemName: "star")
            if let repoId = viewModel.repoDetails?.id {
                viewModel.deleteFavoriteRepo(id: repoId.int64Value)
            }
        }
        
    }
    
    private func reloadView() {
        tableView.reloadData()
        
        switch viewModel.state {
        case .loading:
            configureLoadingState()
        case .done:
            configureDoneState()
        case .failure:
            configureFailureState()
        }
    }
    
    private func configureLoadingState() {
        thumbnailImageView.showAnimatedGradientSkeleton()
        navigationItem.rightBarButtonItem = nil
        emptyMessageLabel.text = "Loading"
        tableView.backgroundView = emptyMessageLabel
    }
    
    private func configureDoneState() {
        navigationItem.rightBarButtonItem = starBarButton
        starBarButtonInitialState()
        thumbnailImageView.hideSkeleton()
        emptyMessageLabel.text = nil
    }
    
    private func configureFailureState() {
        emptyMessageLabel.text = "Error"
        tableView.backgroundView = emptyMessageLabel
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

