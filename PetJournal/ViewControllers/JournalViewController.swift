//
//  JournalViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-22.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import  CoreData

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var journalTV: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    
    let segueDetail = "segueToJournalDetail"
    
    private var entry: NSManagedObject?
    
    private var pets = Pets()
    var pet : NSManagedObject?
    var recievingPetId : Int? //In local list
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       //todo fetch data
        self.journalTV.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalTV.delegate = self
        journalTV.dataSource = self
        
        
        if recievingPetId != nil {
            petDetails()
        }
    }
    
    private func petDetails(){
        pet = pets.entryPet(index: recievingPetId!)

        if pet != nil {
            if let name = pet!.value(forKey: "name") as? String {
                nameLbl.text = name
            }
        }
    }
    
    
    
    @IBAction func newJournalEntry(_ sender: UIButton) {
        
        //TODO popup
    }
    
    //Tableview Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = journalTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JournalTableViewCell
        
        let cellIndex = indexPath.item
        
        
        //TODO
        //entry = veterinaryVisits.entryVisit(listIndex: cellIndex)!
            
        cell.configCell(obj: entry)
        let visitIndex = entry?.value(forKey: "index") as! String
        cell.entryBtn.tag = Int(visitIndex)!
        
        //print("ADDING CELL INDEX: \(visitIndex)")
        
        //Make sure the names arnt upside down since we reversed the order of the cv
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        
        return cell
    }
    

    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueDetail {

            let cell = sender as! UIButton
            
            let journalId = cell.tag

            print(" journalId:  \(journalId)")

           // let destinationVC = segue.destination as! NÅNTING



            

        }
        
        

    }
    
    
    
    
   // ADD DETAIL/event

}
