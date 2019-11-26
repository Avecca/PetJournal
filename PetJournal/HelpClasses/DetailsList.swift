//
//  DetailsList.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-26.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation
import CoreData

struct DetailsList {
   
    
    private static var detailsList: [Detail] = []
    
    func fillDetailsList(entries : [Detail]){
        
        DetailsList.detailsList = entries
    }
    
    func fetchWholeDetailsList() -> [Detail]{
        return DetailsList.detailsList
    }
    
    func countDetails() -> Int{
        DetailsList.detailsList.count
    }
    
    func addDetail(detail: Detail){
        DetailsList.detailsList.append(detail)
    }
    
    
    
}
