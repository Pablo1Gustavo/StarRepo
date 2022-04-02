import Foundation
import CoreData

@objc(FavRepo)
public class FavRepo: NSManagedObject, RepositoryProtocol {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavRepo> {
        return NSFetchRequest<FavRepo>(entityName: "FavRepo")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: NSNumber
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String
    
}
