//
//  CDPerson+CoreDataProperties.swift
//  PersonInfo
//
//  Created by Zune Moe on 01/08/2021.
//
//

import Foundation
import CoreData


extension CDPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPerson> {
        return NSFetchRequest<CDPerson>(entityName: "CDPerson")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var friends: NSObject?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: NSObject?
    @NSManaged public var friend: NSSet?

    public var wrappedAbout: String {
        about ?? "N/A"
    }
    
    public var wrappedAddress: String {
        address ?? "N/A"
    }
    
    public var wrappedCompany: String {
        company ?? "N/A"
    }
    
    public var wrappedEmail: String {
        email ?? "N/A"
    }
    
    public var wrappedID: String {
        id ?? "N/A"
    }
    
    public var wrappedName: String {
        name ?? "N/A"
    }
    
    public var wrappedRegistered: String {
        registered ?? "N/A"
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let date = formatter.date(from: wrappedRegistered) ?? Date()
        return formatter.string(from: date)
    }
    
    public var friendArray: [CDFriend] {
        let set = friends as? Set<CDFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var tagArray: [String] {
        let set = tags as? Set<String> ?? []
        return set.sorted()
    }
}

// MARK: Generated accessors for friend
extension CDPerson {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CDFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CDFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CDPerson : Identifiable {

}
