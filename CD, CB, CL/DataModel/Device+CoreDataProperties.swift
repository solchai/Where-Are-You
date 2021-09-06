//
//  Device+CoreDataProperties.swift
//  Device
//
//  Created by Solomon Chai on 2021-09-05.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var deviceType: String
    @NSManaged public var uuid: String

}

extension Device : Identifiable {

}
