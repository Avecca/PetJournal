//
//  VeterinaryVisits.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct VeterinaryVisits {
        //struct kan inte använda arv och objecten kan inte refereras på från flera olika instanser
    
    let entityName = "Visit"
    
    
    func countVisists() -> Int {
        return PetList.petList.count
    }
    
    func addVisit(name : String, type : String, race : String, id: String)  -> Bool{  //Pet  //obj: NSManagedObject
        
        
        //TODO
        let context = getContext()
        
            if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
                  let visit = NSManagedObject(entity: entity, insertInto: context)
                
                let index =  countVisists() + 1
                visit.setValue(index, forKey: "index")
//                visit.setValue(name, forKeyPath: "name")
//                visit.setValue(type, forKeyPath: "type")
//                visit.setValue(race, forKeyPath: "race")
//                visit.setValue(id, forKeyPath: "id")
                
                
                do {
                    try context.save()
                    VeterinaryVisitsList.vetList.append(visit)
                    print("Visit saved")
                    return true
                } catch let err as NSError {
                    print("Unable to save VISIT. \(err), \(err.userInfo)")
                    
                }
            }
        return false
 
    }
    
    func fetchVisits(){
        let context = getContext()
        
        let fetchRq = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        
        do {
            VeterinaryVisitsList.vetList = try context.fetch(fetchRq)
            // TODO order them fro due time
        } catch let err as NSError {
            print("Unable to fetch pets. \(err), \(err.userInfo)")
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    func deleteVisit(index: Int){
        
        let visit = PetList.petList[index]
        let visitIndex = visit.value(forKeyPath: "index") as? String
        
        let context = getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = NSPredicate(format: "index = %@ ", visitIndex as! CVarArg)
        

        do {
            guard let result = try? context.fetch(request) as! [NSManagedObject] else { return }
            
            if result.count > 0 {
                context.delete(result[0])
                VeterinaryVisitsList.vetList.remove(at: index)

                print("DELETEING ITEM FROM DB AND LIST")
            }
            
//            for obj in result {
//                context.delete(obj)
//            }
            //TODO Kom ihåg detta
            try context.save()
        
        } catch let err as NSError {
            print("Unable to find pet to delete. \(err), \(err.userInfo)")
            
        }
        
    }
    
    func entryVisit(index: Int) -> NSManagedObject? {
        
        if index >= 0 && index <= VeterinaryVisitsList.vetList.count {
            return VeterinaryVisitsList.vetList[index]
        }
        
        return nil
    }
    
}

        //Todo bryt ut appdelegate, managedcontext, entity så bara 1 gång
        
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        let context = appDelegate.persistentContainer.viewContext

        
//        guard let entity = NSEntityDescription.entity(forEntityName: "Pet", in: context) else { return
//
//        }
//
//        let pet = NSManagedObject(entity: entity, insertInto: context)
//
//        pet.setValue(name, forKeyPath: "name")
//
//
//        do {
//            try context.save()
//            PetList.petList.append(pet)
//        } catch let err as NSError {
//            print("unable to save pet. \(err), \(err.userInfo)")
//        }
        
        //PetList.petList.append(obj)
        //petList.append(pet)

