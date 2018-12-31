//
//  Books+CoreDataProperties.swift
//  Parsing
//
//  Created by Sai Sailesh Kumar Suri on 02/11/18.
//  Copyright © 2018 Honeywell. All rights reserved.
//
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var version: String?
    @NSManaged public var country: String?
    @NSManaged public var snippet: String?

}
