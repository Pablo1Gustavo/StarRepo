import Foundation
import Form
import Core

public final class RepoDetailsViewModel {
    private(set) var repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
}
