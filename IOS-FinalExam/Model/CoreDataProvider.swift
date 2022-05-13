import Foundation
import CoreData


protocol CoreDataProviderProtocol {

    func save( context : NSManagedObjectContext ) -> UUID?
           
    func delete( context : NSManagedObjectContext ) -> Bool
    
}

    

class CoreDataProvider {
    
        
    static func all(context : NSManagedObjectContext, entityName : String, sortDescriptors : [NSSortDescriptor] = []) -> [Any?] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        if sortDescriptors.count > 0 {
            request.sortDescriptors = sortDescriptors
        }
        
        do {
            let allObjects = try context.fetch(request)
            return allObjects
        } catch {
            print("**** EXCEPTION at CoreDataProvider.all **** \n \(error.localizedDescription)")
            return []
        }
    }
    

    static func findBy( context : NSManagedObjectContext, entityName : String, key : String, value : String) -> Any? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        request.predicate = NSPredicate(format: "\(key) == %@", value)
        
        // Perform the fetch request to get the objects
        // matching the predicate
        do {
            let objects = try context.fetch(request)
            if objects.count > 0{
                return objects[0]
            } else {
                return nil
            }
        } catch {
            print("**** EXCEPTION at CoreDataProvider.findBy **** \n \(error.localizedDescription)")
            return nil
        }
        
    }

    
    static public func save( context : NSManagedObjectContext ) throws {
        
        do {
            try context.save()
        } catch {
            print("**** EXCEPTION at CoreDataProvider.save **** \n \(error.localizedDescription)")
            throw error
        }
       
    }
    
    
    
    static func delete( context : NSManagedObjectContext, objectToDelete : NSManagedObject ) throws -> Bool {
        
        context.delete(objectToDelete)
        
        do {
            try save(context: context)
            return true
        } catch {
            print("**** EXCEPTION at CoreDataProvider.delete **** \n \(error.localizedDescription)")
            throw error
        }
        
    }

    
    
}
