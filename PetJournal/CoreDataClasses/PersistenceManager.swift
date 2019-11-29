//
//  PersistenceManager.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-26.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation
import CoreData


final class PersistenceManager { //not able to subclass it
    
    
    private init(){
        
    }
    static let shared = PersistenceManager()  //singleton
    
    lazy var context = persistentContainer.viewContext
    


    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PetJournal")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () -> Bool {
       // let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Saving through new method")
                return true
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               
            }
        }
        return false
    }
    
    func fetchAll<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        
        let entityName = String(describing: objectType)
        
        let fetchRq = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjs = try  context.fetch(fetchRq) as? [T]
            return fetchedObjs ?? []
        } catch let err as NSError {
            print("Unable to fetch objects. \(err), \(err.userInfo)")
            return []
        }
        
    }
    
    
    
    
    
}
