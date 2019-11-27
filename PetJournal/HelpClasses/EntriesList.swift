//
//  EntriesList.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-26.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation
import CoreData

struct EntriesList {
   
    
    private static var entriesList: [Entry] = []
    
    func fillEntriesList(entries : [Entry]){
        
        EntriesList.entriesList = entries
    }
    
    func fetchWholeEntriesList() -> [Entry]{
        return EntriesList.entriesList
    }
    
    func countEntries() -> Int{
        EntriesList.entriesList.count
    }
    
    func addEntry(entry: Entry){
        EntriesList.entriesList.append(entry)
    }
    
    func findEntryByDBIndex(index: Int32) -> Entry? {
        if let Obj = EntriesList.entriesList.first(where:{$0.value(forKeyPath: "index")as! Int32 == index}){
            
        
        //firstIndex(where:{$0.value(forKeyPath: "index")as! String == index}){
            
            // print("Trying to remove index \(indexString) from listindex \(listIndex)")
            return Obj
        }
        return nil
    }
    
    
    
}
