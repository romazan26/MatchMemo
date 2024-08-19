//
//  Event+CoreDataProperties.swift
//
//
//  Created by Роман on 16.08.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(Event)
public class Event: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var discription: String?
    @NSManaged public var photo: UIImage?

}

extension Event : Identifiable {

}
