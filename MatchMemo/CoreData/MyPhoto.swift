//
//  MyPhoto+CoreDataProperties.swift
//
//
//  Created by Роман on 14.08.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(MyPhoto)
public class MyPhoto: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyPhoto> {
        return NSFetchRequest<MyPhoto>(entityName: "MyPhoto")
    }

    @NSManaged public var photo: UIImage?

}

extension MyPhoto : Identifiable {

}
