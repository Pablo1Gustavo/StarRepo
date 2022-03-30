import CoreData
import Core

///Protocol for updating data from FavoritesRepos
protocol FetchFavoriteReposProtocol {
    func fetchFavoriteRepos(onCompletionHandler: (Result<[FavRepo], Error>) -> Void)
}

///Protocol for adding data in FavoritesRepos
protocol AddFavoriteRepoProtocol {
    func addFavoriteRepo(title: String, desc: String, imageURL: String)
    func saveData()
}

///Protocol for deleting data from FavoritesRepos
protocol DeleteFavoriteRepoProtocol {
    func deleteFavoriteRepo(uuid: UUID)
}

public class Persistence: ObservableObject {
    
    //setting up CoreDataContainer
    let container: NSPersistentContainer
    
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
    
}

extension Persistence: FetchFavoriteReposProtocol {
    public func fetchFavoriteRepos(onCompletionHandler: (Result<[FavRepo], Error>) -> Void) {
        
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<FavRepo> = FavRepo.fetchRequest()
        
        do {
            let favRepoList = try context.fetch(fetchRequest)
            
            onCompletionHandler(.success(favRepoList))
            
        } catch let error {
            onCompletionHandler(.failure(error))
        }
    }
}

extension Persistence: AddFavoriteRepoProtocol {
    
    public func addFavoriteRepo(title: String, desc: String, imageURL: String) {
        let context = container.viewContext
        
        let favRepo = FavRepo(context: context)
        
        favRepo.title = title
        favRepo.desc = desc
        favRepo.id = UUID()
        favRepo.imageURL = imageURL
        
        saveData()
    }
    
    func saveData() {
        let context = container.viewContext
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error saving. \(error.localizedDescription)")
        }
    }
}

extension Persistence: DeleteFavoriteRepoProtocol {
    public func deleteFavoriteRepo(uuid: UUID) {
        let context = container.viewContext
        
        let predicate = NSPredicate(format: "id == %@", "\(uuid)")
        
        let fetchRequest: NSFetchRequest<FavRepo> = FavRepo.fetchRequest()
        
        fetchRequest.predicate = predicate
        
        do {
            
            //o casting é necessário para que o código saiba o que está trazendo do banco
            let fetchResults = try context.fetch(fetchRequest)
            
            //garantindo que o id existe
            if let entityDelete = fetchResults.first {
                context.delete(entityDelete)
                saveData()
            }
            
            
        } catch let error {
            print("Error Deleting \(error)")
        }
    }
    
    
}

