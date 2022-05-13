//
//  Employee.swift
//  IOS-FinalExam
//
//  Created by Aafrin Sayani on 2022-04-28.
//

import Foundation
import CoreData

extension Employee : CoreDataProviderProtocol {
    
    static let entityName : String = "Employee"
    
    static func all(context : NSManagedObjectContext) -> [Employee] {
        return CoreDataProvider.all(context: context, entityName: entityName) as! [Employee]
    }
    
    func save(context: NSManagedObjectContext) -> UUID? {
        if self.uuid == nil {
            self.uuid = UUID()
        }
        do {
            try CoreDataProvider.save(context: context)
            return self.uuid
        } catch {
            return nil
        }
    }
    
    func delete(context: NSManagedObjectContext) -> Bool {
        
        do {
            let result = try CoreDataProvider.delete(context: context, objectToDelete: self)
            return result
        } catch {
            return false
        }
        
    }
    
}
