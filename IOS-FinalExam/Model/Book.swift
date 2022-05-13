import Foundation
import CoreData


extension Book : CoreDataProviderProtocol {
    
    static let entityName : String = "Book"
    
    static func all(context : NSManagedObjectContext) -> [Book] {
        return CoreDataProvider.all(context: context, entityName: entityName) as! [Book]
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

