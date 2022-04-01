import Foundation
import Core

public typealias completion = (Result<String, FavError>) -> Void

public enum FavError: Error {
    case failFetchingFavorites
    case failSavingFavorite
    case failDeletingFavorite
}

///Protocol for updating data from FavoritesRepos
protocol FetchFavoriteReposProtocol {
    func fetchFavoriteRepos(onCompletionHandler: (Result<[FavRepo], FavError>) -> Void)
}

///Protocol for adding data in FavoritesRepos
protocol AddFavoriteRepoProtocol {
    func addFavoriteRepo(id: Int, title: String, desc: String, imageURL: String)
    func saveData(onCompletionHandler: completion)
}

///Protocol for deleting data from FavoritesRepos
protocol DeleteFavoriteRepoProtocol {
    func deleteFavoriteRepo(id: Int64, onCompletionHandler: completion)
}
