//
//  Detail+CoreDataProperties.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-26.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var category: String?
    @NSManaged public var info: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var index: Int32
    @NSManaged public var entry: Entry?

}
