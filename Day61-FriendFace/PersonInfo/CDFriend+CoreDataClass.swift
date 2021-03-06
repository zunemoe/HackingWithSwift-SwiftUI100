//
//  CDFriend+CoreDataClass.swift
//  PersonInfo
//
//  Created by Zune Moe on 01/08/2021.
//
//

import Foundation
import CoreData

@objc(CDFriend)
public class CDFriend: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    enum DecoderConfigurationError: Error {
        case missingManagedObjectContext
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext!] as? NSManagedObjectContext
//              ,
//              let entity = NSEntityDescription.entity(forEntityName: "CDFriend", in: context)
              else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
//        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)        
        try container.encode(name, forKey: .name)
    }
}
