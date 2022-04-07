import CoreData
import Core

public class Persistence: ObservableObject {
    
    public let container: NSPersistentContainer
    
    public init(inMemory: Bool = false) {
        let managedObjectModel = NSManagedObjectModel(contentsOf: Bundle.module.url(forResource: "FavoritesRepos", withExtension: "momd")!)
        container = NSPersistentContainer(name: "FavoritesRepos", managedObjectModel: managedObjectModel!)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    public static var shared: Persistence = {
        let instance = Persistence()
        return instance
    }()
    
}

extension Persistence: FetchFavoriteReposProtocol {
    public func fetchFavoriteRepos(onCompletionHandler: (Result<[FavRepo], FavError>) -> Void) {
        
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<FavRepo> = FavRepo.fetchRequest()
        
        do {
            let favRepoList = try context.fetch(fetchRequest)
            
            onCompletionHandler(.success(favRepoList))
            
        } catch {
            onCompletionHandler(.failure(.failFetchingFavorites))
        }
    }
}

extension Persistence: AddFavoriteRepoProtocol {
    
    public func addFavoriteRepo(id: NSNumber, name: String, desc: String, imageURL: String) {
        let context = container.viewContext
        
        let favRepo = FavRepo(context: context)
        
        favRepo.name = name
        favRepo.desc = desc
        favRepo.id = id
        favRepo.imageURL = imageURL
        
        saveData { result in
            switch result {
            case .success(let res):
                print(res)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    public func saveData(onCompletionHandler: completion) {
        let context = container.viewContext
        
        do {
            try context.save()

            onCompletionHandler(.success("Save Success"))
        } catch {
            onCompletionHandler(.failure(.failSavingFavorite))
        }
    }
}

extension Persistence: DeleteFavoriteRepoProtocol {

    public func deleteFavoriteRepo(id: Int64, onCompletionHandler: completion) {

        let context = container.viewContext
        
        let predicate = NSPredicate(format: "id == %@", "\(id)")
        
        let fetchRequest: NSFetchRequest<FavRepo> = FavRepo.fetchRequest()
        
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchResults = try context.fetch(fetchRequest)
            
            //garantindo que o id existe
            if let entityDelete = fetchResults.first {
                context.delete(entityDelete)
                
                onCompletionHandler(.success("Delete Success"))
                
                saveData { result in
                    switch result {
                    case .success(let res):
                        print(res)
                    case.failure(let error):
                        print(error)
                    }
                }
            }
        } catch {
            onCompletionHandler(.failure(.failDeletingFavorite))
        }
    }
    
}
