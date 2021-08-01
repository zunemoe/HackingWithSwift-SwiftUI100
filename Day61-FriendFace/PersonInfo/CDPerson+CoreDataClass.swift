//
//  CDPerson+CoreDataClass.swift
//  PersonInfo
//
//  Created by Zune Moe on 31/07/2021.
//
//

import Foundation
import CoreData
//https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/
@objc(CDPerson)
public class CDPerson: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    enum DecoderConfigurationError: Error {
        case missingManagedObjectContext
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext!] as? NSManagedObjectContext
//              ,
//              let entity = NSEntityDescription.entity(forEntityName: "CDPerson", in: context)
              else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
//        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)       
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(String.self, forKey: .registered)
        self.tags = try container.decode(Set<String>.self, forKey: .tags) as NSSet
        self.friends = try container.decode(Set<CDFriend>.self, forKey: .friends) as NSSet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(tags as! Set<String>, forKey: .tags)
        try container.encode(friends as! Set<CDFriend>, forKey: .friends)
        
    }
}
