import Foundation
import Core

public typealias completion = (Result<String, FavError>) -> Void

public enum FavError: Error {
    case failFetchingFavorites
    case failSavingFavorite
    case failDeletingFavorite
}

///Protocol for updating data from FavoritesRepos
public protocol FetchFavoriteReposProtocol {
    func fetchFavoriteRepos(onCompletionHandler: (Result<[FavRepo], FavError>) -> Void)
}

///Protocol for adding data in FavoritesRepos
public protocol AddFavoriteRepoProtocol {
    func addFavoriteRepo(id: NSNumber, name: String, desc: String, imageURL: String)
    func saveData(onCompletionHandler: completion)
}

///Protocol for deleting data from FavoritesRepos
public protocol DeleteFavoriteRepoProtocol {
    func deleteFavoriteRepo(id: Int64, onCompletionHandler: completion)
}
