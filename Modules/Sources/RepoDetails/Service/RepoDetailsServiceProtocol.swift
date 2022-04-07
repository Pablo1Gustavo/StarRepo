import Foundation
import Core

public protocol RepoDetailsServiceProtocol {
    func fetchRepositorieDetails(id: Int, completion: @escaping (Result<Repository, Error>) -> Void)
}
