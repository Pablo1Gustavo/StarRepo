import UIKit
import Form
import Extensions
import Kingfisher
import MessageUI

public class DeveloperDetailsViewController: FormViewController {
    
    private var viewModel: DeveloperDetailsViewModel
    
    private var sections: [FormSection] = []
    
    private lazy var profileImageView: UIImageView = {
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
    
    public init(viewModel: DeveloperDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            .init(
                title: "Section 1",
                rows: [
                    TextRow(text: "Lorem ipsum")
                ])
        ]
        
        delegate = self
        
        configureNavigationBar()
        configureTableHeaderView()
        
        configure(with: viewModel.developer)
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        title = viewModel.developer.name
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureTableHeaderView() {
        
        tableHeaderView.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 16),
            profileImageView.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -16),
            profileImageView.centerXAnchor.constraint(equalTo: tableHeaderView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        tableView.tableHeaderView = tableHeaderView
        
    }
    
    private func configure(with model: Developer) {
        if let url = URL(string: model.profileImageURL) {
            profileImageView.kf.setImage(with: url)
        }
        
        sections = [
            FormSection(
                title: nil,
                rows: [
                    TextRow(
                        text: model.aboutMe
                    )
                ]
            ),
            FormSection(
                title: nil,
                rows: [
                    TitleDescriptionRow(
                        image: .init(systemName: "phone"),
                        title: "Phone number",
                        description: model.phoneNumber
                    ),
                    TitleDescriptionRow(
                        image: .init(systemName: "envelope"),
                        title: "Email",
                        description: model.email,
                        action: { [weak self] in
                            self?.sendEmail(for: model.email)
                        }
                    ),
                    TitleDescriptionRow(
                        image: .init(systemName: "globe"),
                        title: "LinkedIn",
                        description: model.social.linkedinURL,
                        action: { [weak self] in
                            self?.performURL(for: model.social.linkedinURL)
                        }
                    ),
                    TitleDescriptionRow(
                        image: .init(systemName: "globe"),
                        title: "GitHub",
                        description: model.social.githubURL,
                        action: { [weak self] in
                            self?.performURL(for: model.social.githubURL)
                        }
                    ),
                    TitleDescriptionRow(
                        image: .init(systemName: "globe"),
                        title: "Twitter",
                        description: model.social.twitterURL ?? "No Twitter provided",
                        configurationHandler: { config in
                            if model.social.twitterURL == nil {
                                config.descriptionFont = .preferredFont(for: .body, weight: .regular)
                                config.descriptionTextColor = .systemRed
                            }
                        },
                        action: { [weak self] in
                            if let url = model.social.twitterURL {
                                self?.performURL(for: url)
                            }
                        }
                    )
                ]
            )
        ]
    }
    
    private func sendEmail(for email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.delegate = self
            mailComposeViewController.setToRecipients([email])
            
            present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("You cannot send an email")
        }
    }
    
    private func performURL(for urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

}

extension DeveloperDetailsViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

extension DeveloperDetailsViewController: FormDelegate {
    
    public func buidSections() -> [FormSection] {
        return sections
    }
    
}

#if DEBUG
import SwiftUI
import Core

struct DeveloperDetailsViewControllerPreviews: PreviewProvider {
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
            let viewModel = DeveloperDetailsViewModel(
                developer: Developer.debugDevelopers[0]
            )
            
            let viewController = DeveloperDetailsViewController(
                viewModel: viewModel
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
