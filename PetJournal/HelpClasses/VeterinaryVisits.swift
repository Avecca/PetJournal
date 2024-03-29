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
    
    private let entityName = "Visit"
    private let entityPet = "Pet"
    private var index = 0
    //TODO context var up here
    
    private let manager = PersistenceManager.shared
    
    
    func countVisits() -> Int {
        return VeterinaryVisitsList.vetList.count
    }
    
    mutating func addVisit(reason : String, time : Date, info: String, petNames: [String])  -> Bool{  //Pet  //obj: NSManagedObject
  
      
        let context = manager.context // getContext()
        
        let v = Visit(context: context)
        v.reason = reason
        v.date = time
        v.info = info
        
        self.index = 0
        
        if (countVisits() > 0 ){
            
            for item in VeterinaryVisitsList.vetList {
                
                let x = item.value(forKey: "index") as! String

                if  Int(x)! > self.index {
                    self.index = Int(x)!
                }
            }
        }
        
        self.index += 1
        v.index = String(self.index)
        
        if petNames != [] {
            var p = Pet()
            for pet in petNames {
                p = PetList.petList.first(where: {$0.name == pet})!
                v.addToPets(p)
            }
        }
        
        do {
            try context.save()
            
            print(v)
            VeterinaryVisitsList.vetList.append(v)
            print("Visit saved W INDEX: \(self.index)")
            
            return true
        } catch let err as NSError {
            print("Unable to save VISIT. \(err), \(err.userInfo)")
            
        }
        
        


        return false
    }
    
    func updateVisits(index: Int, reason : String, time : Date, info: String, petNames: [String]) -> Bool {
        
        let indexString = String(index)
        let context = manager.context //getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        request.predicate = NSPredicate(format: "index = %@ ", indexString as CVarArg)

            guard let result = try? context.fetch(request)  else { return false }
                
            if result.count > 0 {
                    
                let obj = result[0] as! NSManagedObject
                obj.setValue(reason, forKeyPath: "reason")
                obj.setValue(time, forKeyPath: "date")
                obj.setValue(info, forKeyPath: "info")
                    
                do {
                    //save changes
                    try context.save()
                      
                    
                    
                    if let foundIndex = findVisitListIndex(index: indexString)  {
                        print("INDEX FOUND")
                       // VeterinaryVisitsList.vetList[foundIndex] = obj
                        updatPetsOnVisit(localListIndex: foundIndex, petNames: petNames)
                    }
                    
                    return true
                    
                } catch let err as NSError {
                    print("Unable to update visit \( String(describing: err.localizedFailureReason))")
                }
            }
        return false
    }
    
    private func updatPetsOnVisit(localListIndex: Int,  petNames: [String]){
        let context = manager.context
        let v = VeterinaryVisitsList.vetList[localListIndex] as! Visit
        
        for pet in v.pets! {
            v.removeFromPets(pet as! Pet)
        }
        
        if petNames != [] {
            print("pets are NOT nil")
            var p = Pet()
            for pet in petNames {
                p = PetList.petList.first(where: {$0.name == pet})!
                print("found pet to add to visit!")
                v.addToPets(p)
            }
        }
        
        do {
            try context.save()
            
            print(v)
 
            print("Visit UPDATED W INDEX: \(self.index)")

        } catch let err as NSError {
            print("Unable to UPDATE VISIT. \(err), \(err.userInfo)")
            
        }
        
        
    }
    
    func fetchVisits(){
        
        let context = manager.context// getContext()
        
        let fetchRq = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRq.sortDescriptors = [sort]
        
        do {
            VeterinaryVisitsList.vetList = try context.fetch(fetchRq)
            // TODO order them fro due time
        } catch let err as NSError {
            print("Unable to fetch visits. \(err), \(err.userInfo)")
        }
    }
    
    func deleteVisit(index: Int){
        
//        let visit = VeterinaryVisitsList.vetList[index]
//        let visitIndex = visit.value(forKeyPath: "index") as? String
        let indexString = String(index)
        
        let context = manager.context//getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = NSPredicate(format: "index = %@ ", indexString as CVarArg)
        

        //do {
        guard let result = try? (context.fetch(request) as! [NSManagedObject]) else { return }
        
        if result.count > 0 {
            //delete from DB
            context.delete(result[0])
            
            
            do {
                 try context.save()   //Save the delete try TODO Kom ihåg detta

                 print("DELETEING ITEM FROM DB AND LIST with index : \(indexString)")
            } catch  {
                print(error)
            }

        }
//            for obj in result {
//                context.delete(obj)
//            }
                   
//
//        } catch let err as NSError {
//            print("Unable to find visit to delete. \(err), \(err.userInfo)")
//        }
    }
    
    private func findVisitListIndex(index: String) -> Int? {
        print("print local index \(index)")
        if let listIndex = VeterinaryVisitsList.vetList.firstIndex(where:{$0.value(forKeyPath: "index")as! String == index}){
            
            // print("Trying to remove index \(indexString) from listindex \(listIndex)")
            return listIndex
        }
        return nil
    }
    
    func findVisitByDBIndex(index: Int) -> NSManagedObject? {
        
        if index >= 0  {
            
            if let listIndex = findVisitListIndex(index: String(index)) {
                
                return entryVisit(listIndex: listIndex)
            }
        }
        return nil
    }
    
    func reOrderVetList(){
        fetchVisits()
    }

    
    func entryVisit(listIndex: Int) -> NSManagedObject? {
        if listIndex >= 0 && index <= VeterinaryVisitsList.vetList.count  {
            return VeterinaryVisitsList.vetList[listIndex]
        }
        return nil
    }
    
    
    
}

//    private func getContext() -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }

       
        
        
        
//            if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
//
//                let visit = NSManagedObject(entity: entity, insertInto: context)
//                self.index = 0
//
//                if (countVisits() > 0 ){
//
//                    for item in VeterinaryVisitsList.vetList {
//
//                        let x = item.value(forKey: "index") as! String
//
//                        if  Int(x)! > self.index {
//                            self.index = Int(x)!
//                        }
//                    }
//                }
//
//                self.index += 1
//
//                visit.setValue(String(self.index), forKey: "index")
//                visit.setValue(reason, forKeyPath: "reason")
//                visit.setValue(time, forKeyPath: "date")
//                if info != "" {
//                    visit.setValue(info, forKeyPath: "info")
//                }
//                if petNames != [] {
//
//
//
//                    //var x = 0
////                    print("petnames NOT EMPTY")
////



////
////
////                    let con = getContext()
////                    for pet in petNames {
////
////                        print("PETNAME: \(pet)")
////                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityPet)
////                        fetchRequest.predicate = NSPredicate(format: "name = %@ ", pet as CVarArg)
////
////                        guard let r = try? (con.fetch(fetchRequest) as! [NSManagedObject]) else { return false }
////
////                        print("ITERATING")
////
////                        visit.setValue(NSSet(object: r[0]), forKey: "pets")
////                        //visit.setValue(r[0], forKey: "pets")
////                        print("ITERATINGAFTER SET \(r[0])")
////                        //x += 1
////                    }
//
//                }
//
//                //TODO Add Pets
////                visit.setValue(id, forKeyPath: "id")
//                print(context)
//
//                do {
//                    try context.save()
//                    VeterinaryVisitsList.vetList.append(visit)
//                    print("Visit saved W INDEX: \(self.index)")
//
//
//                    return true
//                } catch let err as NSError {
//                    print("Unable to save VISIT. \(err), \(err.userInfo)")
//
//                }
//            }


