//
//  Device+CoreDataProperties.swift
//  Device
//
//  Created by Solomon Chai on 2021-09-04.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String
    @NSManaged public var ownerImage: Data?

}

extension Friend : Identifiable {

}
