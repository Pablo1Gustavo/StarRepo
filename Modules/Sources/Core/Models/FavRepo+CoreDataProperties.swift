//
//  FavRepo+CoreDataProperties.swift
//  StarRepo
//
//  Created by Sandra Monteiro de Castro on 24/03/22.
//
//

import Foundation
import CoreData


extension FavRepo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavRepo> {
        return NSFetchRequest<FavRepo>(entityName: "FavRepo")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageURL: String?
    @NSManaged public var title: String?

}
