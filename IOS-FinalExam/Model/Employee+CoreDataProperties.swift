//
//  Employee+CoreDataProperties.swift
//  IOS-FinalExam
//
//  Created by Aafrin Sayani on 2022-04-28.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?

}

extension Employee : Identifiable {

}
