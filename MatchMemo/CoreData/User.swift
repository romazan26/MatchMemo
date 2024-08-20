//
//  User+CoreDataProperties.swift
//
//
//  Created by Роман on 20.08.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(User)
public class  User: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var experience: Int16
    @NSManaged public var name: String?
    @NSManaged public var photo: UIImage?

}

extension User : Identifiable {

}
