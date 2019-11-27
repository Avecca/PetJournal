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
    
    func updateDetailInlist(detailObj: Detail, info : String?){

        if let listIndex = DetailsList.detailsList.firstIndex(where:{$0.value(forKeyPath: "index") as! Int32 == detailObj.index}){
            
            DetailsList.detailsList[listIndex] = detailObj
            
        }
    }
    
    func findDetailByDBIndex(index: Int32) -> Detail? {
        if let Obj = DetailsList.detailsList.first(where:{$0.value(forKeyPath: "index")as! Int32 == index}){
            
        
        //firstIndex(where:{$0.value(forKeyPath: "index")as! String == index}){
            
            // print("Trying to remove index \(indexString) from listindex \(listIndex)")
            return Obj
        }
        return nil
    }
    
    
    
}
