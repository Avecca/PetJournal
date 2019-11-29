//
//  Pet+CoreDataProperties.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-26.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String
    @NSManaged public var race: String?
    @NSManaged public var type: String?
    @NSManaged public var birthDate: Date?
    @NSManaged public var entry: NSSet?
    @NSManaged public var visits: NSSet?

}

// MARK: Generated accessors for entry
extension Pet {

    @objc(addEntryObject:)
    @NSManaged public func addToEntry(_ value: Entry)

    @objc(removeEntryObject:)
    @NSManaged public func removeFromEntry(_ value: Entry)

    @objc(addEntry:)
    @NSManaged public func addToEntry(_ values: NSSet)

    @objc(removeEntry:)
    @NSManaged public func removeFromEntry(_ values: NSSet)

}

// MARK: Generated accessors for visits
extension Pet {

    @objc(addVisitsObject:)
    @NSManaged public func addToVisits(_ value: Visit)

    @objc(removeVisitsObject:)
    @NSManaged public func removeFromVisits(_ value: Visit)

    @objc(addVisits:)
    @NSManaged public func addToVisits(_ values: NSSet)

    @objc(removeVisits:)
    @NSManaged public func removeFromVisits(_ values: NSSet)

}
