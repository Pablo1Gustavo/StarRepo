import Foundation

final class AutocompleteSearchResultsViewModel {
    
    private var autocompleteService: HomeAutomcompleteServiceProtocol
    
    private(set) var languages: [String] = []
    private(set) var filteredLanguages: [String]?
    
    private(set) var searchText: String = ""
    
    private(set) var isFiltering = false
    
    // MARK: - Initializers
    
    public init(
        autocompleteService: HomeAutomcompleteServiceProtocol
    ) {
        self.autocompleteService = autocompleteService
        
        self.autocompleteService.fetchLanguages { result in
            switch result {
            case .success(let languages):
                self.languages = languages
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Public methods
    
    func searchLanguages(searchText: String, completion: @escaping () -> Void) {
        self.searchText = searchText
        
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
