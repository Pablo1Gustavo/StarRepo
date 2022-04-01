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
    
}
