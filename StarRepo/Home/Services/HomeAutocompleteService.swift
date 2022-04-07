import Foundation
import Home

struct HomeAutocompleteService: HomeAutomcompleteServiceProtocol {
    
    func fetchLanguages(_ completion: @escaping (Result<[String], Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "programming_languages", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                let result = try decoder.decode([String].self, from: data)
                
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Path not found")
        }
    }
    
}
