import UIKit
import Form
import Core

public class RepoDetailsViewController: FormViewController{
    
    private var viewModel: RepoDetailsViewModel
    
    private var sections: [FormSection] = []
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configure(with: viewModel.repository)
    }
    
    public init(viewModel: RepoDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with model: Repository) {
        sections = [
            FormSection(
                title: nil,
                rows: [
                    TextRow(
                        text: "Test"
                    )
                ]
            )]
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
