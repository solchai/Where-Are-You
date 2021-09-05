//
//  Device+CoreDataProperties.swift
//  Device
//
//  Created by Solomon Chai on 2021-09-04.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var name: String?
    @NSManaged public var ownerImage: Data?

}

extension Device : Identifiable {

}
