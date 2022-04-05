import UIKit

public extension UITableView {
    
    func deselectRow(animated: Bool) {
        if let indexPath = indexPathForSelectedRow {
            deselectRow(at: indexPath, animated: animated)
        }
    }
    
    func deselectRows(animated: Bool) {
        if let indexPaths = indexPathsForSelectedRows {
            for indexPath in indexPaths {
                deselectRow(at: indexPath, animated: animated)
            }
        }
    }
    
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
    
}
