import UIKit

class ButtonRowTableViewCell: FormRowTableViewCell<ButtonRow> {

    static let identifier = "ButtonRowTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override func loadView() {
        super.loadView()
        
        contentStackView.addArrangedSubview(titleLabel)
    }
    
    override func configure(with model: ButtonRow) {
        super.configure(with: model)
        
        titleLabel.font = model.configuration.textFont
        titleLabel.textColor = model.configuration.tintColor
        
        titleLabel.text = model.title
    }

}
