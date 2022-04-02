import Foundation
import Core

struct RepositoriesResponse: Decodable {
    var items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
