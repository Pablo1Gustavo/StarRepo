import UIKit

class TitleDescriptionRowTableViewCell: FormRowTableViewCell<TitleDescriptionRow> {

    static let identifier = "TitleDescriptionTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override func loadView() {
        super.loadView()
        
        contentStackView.addArrangedSubview(titleLabel)
    }
    
    override func configure(with model: TitleDescriptionRow) {
        super.configure(with: model)
        
        let str = "\(model.title): \(model.description)"
        let attributedString = NSMutableAttributedString(string: str)
        
        let titleAttributes: [NSAttributedString.Key : Any] = [
            .font: model.configuration.titleFont,
            .foregroundColor: model.configuration.titleTextColor
        ]
        attributedString.addAttributes(titleAttributes, range: NSRange(location: 0, length: model.title.count + 1))
        
        let descriptionAttributes: [NSAttributedString.Key : Any] = [
            .font: model.configuration.descriptionFont,
            .foregroundColor: model.configuration.descriptionTextColor
        ]
        attributedString.addAttributes(descriptionAttributes, range: NSRange(location: model.title.count + 2, length: model.description.count))
        
        titleLabel.attributedText = attributedString
    }

}
