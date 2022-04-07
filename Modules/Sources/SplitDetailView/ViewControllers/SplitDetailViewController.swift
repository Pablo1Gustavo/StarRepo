import UIKit
import Extensions

public class SplitDetailViewController: UIViewController {
    
    private var viewModel: SplitDetailViewModel
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title1, weight: .semibold)
        label.text = "Message"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    public init(viewModel: SplitDetailViewModel) {
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
        
        configure(with: viewModel.initialMessage)
    }
    
    public override func loadView() {
        super.loadView()
        
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    // MARK: - Private methods
    
    private func configure(with model: String) {
        textLabel.text = model
    }

}

#if DEBUG
import SwiftUI

struct SplitDetailViewControllerPreviews: PreviewProvider {
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
        typealias UIViewControllerType = UIViewController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewModel = SplitDetailViewModel(
                initialMessage: "Select a Repository"
            )
            
            let viewController = SplitDetailViewController(
                viewModel: viewModel
            )
            
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
