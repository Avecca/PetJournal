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

  
    @IBOutlet weak var journalEntryTV: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var petImgView: UIImageView!
    
    let segueDetail = "segueToJournalDetail"
    
    private var entry: Entry?
    private var entries: [Entry]?
    
    private var entriestList = EntriesList()
    private var pets = Pets()
    var pet : Pet?
    
    //TODO Send the whole pet with
    var recievingPetId : Int? //In local list
    
    var selectedTitle: String = ""
    var selectedId: Int?
   
    
    var entryIndex: Int32?
    var newEntry: Bool = false
    
    
    
    //TODO Check on this
    private let manager = PersistenceManager.shared

        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       //todo fetch data
        self.journalEntryTV.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalEntryTV.delegate = self
        journalEntryTV.dataSource = self
        
        
        if recievingPetId != nil {
            petDetails()
            fetchEntries()
        } else{
            //todo dismiss back
        }
        
    }
    
    override func viewDidLayoutSubviews() {
          //collectionview filled from bottom
          journalEntryTV.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
      }
    
    private func petDetails(){
        pet = pets.entryPet(index: recievingPetId!) as? Pet

        if pet != nil {
            if let name = pet?.name { //pet!.value(forKey: "name") as? String {
                nameLbl.text = name
            }
        }
    }
    
    private func fetchEntries(){
        
        
        
        //fill the general entry list
        let es = manager.fetchAll(Entry.self)
        entriestList.fillEntriesList(entries: es)
       // EntriesList.entriesList = manager.fetchAll(Entry.self)
        entryIndex = nil
        
        guard let e =  pet!.entry?.allObjects as? [Entry] else {
            return  }
        
        entries = e
        
    }
    
    
    
    @IBAction func newJournalEntry(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Journal Entry", message: "Add a title for your new Journal Entry", preferredStyle: .alert)
    
        let alertSaveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            
            guard let txtField = alert.textFields?.first, let title = txtField.text else {
                return
            }
            
            //SAVE DATA, title
            self.entryIndex = self.createEntry(title: title)
            
            //GET NEW ENTRY ID entryId =
            print(title + " sending to save")
            self.selectedTitle = title
            self.newEntry = true
            
            self.journalEntryTV.reloadData()
            
            //Segue to Entry page
            self.performSegue(withIdentifier: self.segueDetail, sender: self)
            
        }
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(alertSaveAction)
        alert.addAction(alertCancelAction)
        
        present(alert, animated: true)
        
        
//        let managedObjectContext = persistentContainer.viewContext
//        let e = Entry(context: managedObjectContext)
        
      
    }
    
    private func createEntry(title : String) -> Int32 {
        
        let e = Entry(context: manager.context)
        e.subject = title
        e.timeStamp = Date()
        
        //TODO really necessary?
       // e.index
        self.entryIndex = 0
        
        if entriestList.countEntries() > 0 {
            for item in entriestList.fetchWholeEntriesList() {
                let x = item.index
                if Int32(x) > self.entryIndex! {
                    self.entryIndex = Int32(x)
                }
            }
        }
        
        self.entryIndex! += 1
        e.index = entryIndex!
        
        e.pet = pet
        
        print("Sending to contect to save " + String(describing: e.self))
        manager.saveContext()
        entriestList.addEntry(entry: e)
        entries?.append(e)
        
        
        journalEntryTV.reloadData()
        
        print(e)
        return e.index
    }
    
    //Tableview Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        print("Trying to DEQUEUE")
        let cell = journalEntryTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JournalTableViewCell
        
        let cellIndex = indexPath.item
    

        entry = entries![cellIndex]//veterinaryVisits.entryVisit(listIndex: cellIndex)!
            
        cell.configCell(obj: entry)
        let entryIndex = entry!.index  // entry?.value(forKey: "index") as! String
        cell.journalEntryButton.tag = Int(entryIndex)
        
        //print("ADDING CELL INDEX: \(visitIndex)")
        
        //Make sure the names arnt upside down since we reversed the order of the cv
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        
        return cell
    }
    

    @IBAction func unwindToJournal( segue: UIStoryboardSegue) {
        
        print("unwinded to journal entries w \(String(describing: recievingPetId))")

      }
    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueDetail {

            
            let destinationVC = segue.destination as! EntryDetailViewController
            
            if (!newEntry){
                let cell = sender as! UIButton
                entryIndex = Int32(cell.tag)
                print("Sender is button")
                if let txt = cell.titleLabel?.text{
                    selectedTitle = txt
                }
                
            } else {
                
                  
            }
            
           // let entryId = (cell as AnyObject).tag

            print(" journalId:  \(String(describing: entryIndex))")

            
            destinationVC.recievingEntryTitle = selectedTitle
            //send the whole ITEM
            destinationVC.recievingEntryId = entryIndex
            //destinationVC.recieivingPetName = nameLbl.text
            //destinationVC.recievingPetImg = petImgView.image
            destinationVC.recievingPet = self.pet
            destinationVC.recievingPetId = recievingPetId
            destinationVC.recievingOldVC = self
            // i nästa  var recievingOldVC: JournalViewController!
            

        }
        
        

    }
    
    
    
    
   // ADD DETAIL/event

}
