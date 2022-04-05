import Foundation
import DeveloperTeamList
import Core

struct DeveloperTeamListService: DeveloperTeamListServiceProtocol {
    
    func fetchDevelopers(_ completion: @escaping (Result<[Developer], Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "developers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                var result = try decoder.decode([Developer].self, from: data)
                
                result.sort(by: { $0.name < $1.name })
                
                completion(.success(result))
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        } else {
            print("Path not found")
        }
    }
    
}
