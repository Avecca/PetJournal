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
    
    private let entityName = "Pet"
    //TODO context var up here
    
    
    
    //TODO should not use the appdelegates persistanceocontainer
    private let manager = PersistenceManager.shared
    
    
    func countPets() -> Int {
        return PetList.petList.count
    }
    
    func addPet(name : String, type : String, race : String, id: String)  -> Bool{  //Pet  //obj: NSManagedObject
        
        if checkIfNameAlreadyExistsInList(name: name) {
            return false
        }
        
        let context = manager.context   //getContext()
        
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
                
            let pet = NSManagedObject(entity: entity, insertInto: context)
            pet.setValue(name, forKeyPath: "name")
            pet.setValue(type, forKeyPath: "type")
            pet.setValue(race, forKeyPath: "race")
            pet.setValue(id, forKeyPath: "id")
                
            do {
                try context.save()
                PetList.petList.append(pet as! Pet)
                print("Pet saved")
                return true
            } catch let err as NSError {
                print("Unable to save pet. \(err), \(err.userInfo)")
            }
        }
        return false
    }
    
    func fetchPets(){
        let context = manager.context //getContext()
        
        let fetchRq = NSFetchRequest<Pet>(entityName: entityName) //<Pet>  //NSManagedObject
        
        
        do {
            PetList.petList =  try context.fetch(fetchRq)  //as! [Pet]
            //?? []
        } catch let err as NSError {
            print("Unable to fetch pets. \(err), \(err.userInfo)")
        }
    }
    
//    func getContext() -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
    
    
    func checkIfNameAlreadyExistsInList(name : String) -> Bool{
        
        
        for pet in PetList.petList {
            if (pet.value(forKey: "name") as! String) == name {
                print("Name already exists")
                return true
            }
        }

        return false
    }
    
    
//     func addPet2(obj: NSManagedObject)  { // //Pet
//
//        PetList.petList.append(obj)
//
//     }
    
    func deletePet(index: Int){
        
        
        //TODO Delete mentions in Visits
        
        let pet = PetList.petList[index]
        let name = pet.value(forKeyPath: "name") as? String
        
        let context = manager.context // getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = NSPredicate(format: "name = %@ ", name!)
        

        do {
            guard let result = try? context.fetch(request) as? [NSManagedObject] else { return }
            
            if result.count > 0 {
                context.delete(result[0])
                PetList.petList.remove(at: index)

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
