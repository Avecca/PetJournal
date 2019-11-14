//
//  Pets.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation


struct Pets {
        //struct kan inte använda arv och objecten kan inte refereras på från flera olika instanser
    
    
    
    
    func countPets() -> Int {
        return PetList.petList.count
    }
    
    func addPet(pet: Pet) {
        PetList.petList.append(pet)
        //petList.append(pet)
        //TODO add database
    }
    
    
     func addPet2(pet: Pet)  { //

        PetList.petList.append(pet)

     }
    
    func deletePet(index: Int){
        PetList.petList.remove(at: index)
        //TODO add database
    }
    
    func entryPet(index: Int) -> Pet? {
        
        if index >= 0 && index <= PetList.petList.count {
            return PetList.petList[index]
        }
        
        return nil
    }
    
}
