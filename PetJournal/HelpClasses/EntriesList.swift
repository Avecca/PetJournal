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
    
    
    
}
