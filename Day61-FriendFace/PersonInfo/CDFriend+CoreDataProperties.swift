//
//  CDFriend+CoreDataProperties.swift
//  PersonInfo
//
//  Created by Zune Moe on 01/08/2021.
//
//

import Foundation
import CoreData


extension CDFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var person: NSSet?
    
    public var wrappedID: String {
        id ?? "N/A"
    }
    
    public var wrappedName: String {
        name ?? "N/A"
    }
}

// MARK: Generated accessors for person
extension CDFriend {

    @objc(addPersonObject:)
    @NSManaged public func addToPerson(_ value: CDPerson)

    @objc(removePersonObject:)
    @NSManaged public func removeFromPerson(_ value: CDPerson)

    @objc(addPerson:)
    @NSManaged public func addToPerson(_ values: NSSet)

    @objc(removePerson:)
    @NSManaged public func removeFromPerson(_ values: NSSet)

}

extension CDFriend : Identifiable {

}
