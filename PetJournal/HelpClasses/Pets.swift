//
//  Pets.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct Pets {
        //struct kan inte använda arv och objecten kan inte refereras på från flera olika instanser
    
    let entityName = "Pet"
    
    
    func countPets() -> Int {
        return PetList.petList.count
    }
    
    func addPet(name : String, type : String, race : String)  -> Bool{  //Pet  //obj: NSManagedObject
        
        let context = getContext()
        
            if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
                  let pet = NSManagedObject(entity: entity, insertInto: context)
                
                pet.setValue(name, forKeyPath: "name")
                pet.setValue(type, forKeyPath: "type")
                pet.setValue(race, forKeyPath: "race")
                
                
                do {
                    try context.save()
                    PetList.petList.append(pet)
                    print("Pet saved")
                    return true
                } catch let err as NSError {
                    print("Unable to save pet. \(err), \(err.userInfo)")
                    
                }
        
            }
        return false
 
    }
    
    func fetchPets(){
        let context = getContext()
        
        let fetchRq = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        
        do {
            PetList.petList =  try context.fetch(fetchRq)
        } catch let err as NSError {
            print("Unable to fetch pets. \(err), \(err.userInfo)")
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
     func addPet2(obj: NSManagedObject)  { // //Pet

        PetList.petList.append(obj)

     }
    
    func deletePet(index: Int){
        PetList.petList.remove(at: index)
        //TODO add database
    }
    
    func entryPet(index: Int) -> NSManagedObject? {
        
        if index >= 0 && index <= PetList.petList.count {
            return PetList.petList[index]
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
