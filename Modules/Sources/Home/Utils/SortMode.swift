import Foundation

public enum SortMode: String {
    case ascending = "asc"
    case descending = "desc"
    
    var localizedTitle: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
}
