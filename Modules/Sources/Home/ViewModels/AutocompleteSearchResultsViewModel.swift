import Foundation

final class AutocompleteSearchResultsViewModel {
    
    private(set) var languages: [String] = ["Swift", "Objective-C", "C", "C++", "Ruby", "Python"]
    private(set) var filteredLanguages: [String]?
    
    private(set) var isFiltering = false
    
    // MARK: - Public methods
    
    func searchLanguages(searchText: String, completion: @escaping () -> Void) {
        print(searchText)
        if !searchText.isEmpty {
            isFiltering = true
            filteredLanguages = languages.filter({ $0.range(of: searchText, options: [.caseInsensitive, .diacriticInsensitive]) != nil })
        } else {
            isFiltering = false
            filteredLanguages = languages
        }

        completion()
    }
    
}
