//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Weather")
        
        container.loadPersistentStores { storeDescription, err in
            if let err = err as NSError? {
                fatalError("Unresolved: \(err)")
            }
        }
    }
    
    func saveContext() {
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            fatalError("Error: \(error)")
        }
    }
}
