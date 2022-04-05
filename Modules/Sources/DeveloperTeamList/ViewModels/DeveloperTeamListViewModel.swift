import Foundation
import Core

public final class DeveloperTeamListViewModel {
    
    private var developerListService: DeveloperTeamListServiceProtocol
    
    private(set) var developers: [Developer] = []
    
    public init(developerListService: DeveloperTeamListServiceProtocol) {
        self.developerListService = developerListService
    }
    
    // MARK: - Public methods
    
    func fetchDevs(completion: @escaping () -> Void) {
        developerListService.fetchDevelopers { result in
            switch result {
            case .success(let devs):
                self.developers = devs
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
}
