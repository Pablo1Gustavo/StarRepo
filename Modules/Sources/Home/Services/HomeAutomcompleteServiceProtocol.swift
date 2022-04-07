import Foundation

public protocol HomeAutomcompleteServiceProtocol {
    func fetchLanguages(_ completion: @escaping (Result<[String], Error>) -> Void)
}

#if DEBUG
struct DummyHomeAutomcompleteServiceProtocol: HomeAutomcompleteServiceProtocol {
    func fetchLanguages(_ completion: @escaping (Result<[String], Error>) -> Void) {
        let array = ["Swift", "Objective-C", "C", "C++", "Ruby", "Python"]
        completion(.success(array))
    }
}
#endif
