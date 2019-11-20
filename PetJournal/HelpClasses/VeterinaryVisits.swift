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
    var index = 0
    
    
    func countVisits() -> Int {
        return VeterinaryVisitsList.vetList.count
    }
    
    mutating func addVisit(reason : String, time : Date, info: String, petNames: [String])  -> Bool{  //Pet  //obj: NSManagedObject
        
        
        //TODO
        let context = getContext()
        
            if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
                  
                let visit = NSManagedObject(entity: entity, insertInto: context)
                
                if (countVisits() > 0 ){
                    
                    for item in VeterinaryVisitsList.vetList {
                        
                        let x = item.value(forKey: "index") as! Int

                        if  x > self.index {
                            self.index = x
                        }
                    }
                }
                
                visit.setValue(String(self.index), forKey: "index")
                visit.setValue(reason, forKeyPath: "reason")
                visit.setValue(time, forKeyPath: "date")
                if info != "" {
                    visit.setValue(info, forKeyPath: "info")
                }
                if petNames != [] {
                    //TODO Add pets
                }
                
                //TODO Add Pets
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
            print("Unable to fetch visits. \(err), \(err.userInfo)")
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    func deleteVisit(index: Int){
        
//        let visit = VeterinaryVisitsList.vetList[index]
//        let visitIndex = visit.value(forKeyPath: "index") as? String
        let indexString = String(index)
        
        let context = getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = NSPredicate(format: "index = %@ ", indexString as! CVarArg)
        

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
            print("Unable to find visit to delete. \(err), \(err.userInfo)")
            
        }
        
    }
    
    func entryVisit(index: Int) -> NSManagedObject? {
        
        if index >= 0 && index <= VeterinaryVisitsList.vetList.count  {
            return VeterinaryVisitsList.vetList[index]
        }
        
        return nil
    }
    
}


