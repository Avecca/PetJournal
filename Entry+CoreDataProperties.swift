//
//  Entry+CoreDataProperties.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-26.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var subject: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var index: Int32
    @NSManaged public var detail: NSSet?
    @NSManaged public var pet: Pet?

}

// MARK: Generated accessors for detail
extension Entry {

    @objc(addDetailObject:)
    @NSManaged public func addToDetail(_ value: Detail)

    @objc(removeDetailObject:)
    @NSManaged public func removeFromDetail(_ value: Detail)

    @objc(addDetail:)
    @NSManaged public func addToDetail(_ values: NSSet)

    @objc(removeDetail:)
    @NSManaged public func removeFromDetail(_ values: NSSet)

}
