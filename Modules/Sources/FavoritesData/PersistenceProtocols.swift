import Foundation
import Core

public typealias completion = (Result<String, FavError>) -> Void

public enum FavError: Error {
    case failFetchingFavorites
    case failSavingFavorite
    case failDeletingFavorite
}

///Protocol for updating favorites repositories
protocol FetchFavoriteReposProtocol {
    func fetchFavoriteRepos(onCompletionHandler: (Result<[FavRepo], FavError>) -> Void)
}

///Protocol for adding a new favorite repositorie
protocol AddFavoriteRepoProtocol {
    func addFavoriteRepo(id: String, title: String, desc: String, imageURL: String)
    func saveData(onCompletionHandler: completion)
}

///Protocol for deleting a repositorie from favorites
protocol DeleteFavoriteRepoProtocol {
    func deleteFavoriteRepo(id: String, onCompletionHandler: completion)
}
