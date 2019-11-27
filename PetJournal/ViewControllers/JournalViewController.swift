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
    let segueUnwind = "unwindToPetsWithSegue"
    
    private var entry: Entry?
    private var entries: [Entry]?//[Entry]()
    private var selectedEntry: Entry?
    
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
            self.performSegue(withIdentifier: self.segueUnwind, sender: self)
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
        let allEntries = manager.fetchAll(Entry.self)
        entriestList.fillEntriesList(entries: allEntries)
        entryIndex = nil
        
        guard let entriesOfPet =  pet!.entry?.allObjects as? [Entry] else {
            return  }
        
        //local entries for specific pet
        entries = entriesOfPet
        entries?.sort(by: {$0.index > $1.index})
    }
    
    private func createEntry(title : String) {
        
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
        
        print("Sending to context to save " + String(describing: e.self))
        if (manager.saveContext()){
            entriestList.addEntry(entry: e)
            entries?.append(e)
            selectedEntry = e
        
            journalEntryTV.reloadData()
            print(e)
        }
    }
    
    @IBAction func newJournalEntry(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Journal Entry", message: "Add a title for your new Journal Entry", preferredStyle: .alert)
    
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let alertSaveAction = UIAlertAction(title: "Save Entry", style: .default){
            [unowned self] action in
            
            guard let txtField = alert.textFields?.first, let title = txtField.text else {
                return
            }
            
            let capTitle = title.capitalized(with: NSLocale.current)
            //SAVE DATA, title
            self.createEntry(title: capTitle)
            
            //GET NEW ENTRY ID entryId =
            print(title + " sending to save")
            self.selectedTitle = title
            self.newEntry = true

            
            //Segue to Entry page
            self.performSegue(withIdentifier: self.segueDetail, sender: self)
            
        }
        
        alert.addTextField()
        alert.addAction(alertSaveAction)
        alert.addAction(alertCancelAction)
        
        present(alert, animated: true)
    }
    

    //Tableview Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = journalEntryTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JournalTableViewCell
        let cellIndex = indexPath.item
        entry = entries![cellIndex]
            
        cell.configCell(obj: entry)
        let entryIndex = entry!.index
        cell.journalEntryButton.tag = Int(entryIndex)
        
        //Make sure the names arnt upside down since we reversed the order of the cv
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        return cell
    }
    
    //Segues
    @IBAction func unwindToJournal( segue: UIStoryboardSegue) {
        
        print("unwinded to journal entries w \(String(describing: recievingPetId))")
        self.newEntry = false
        
        self.fetchEntries()
        journalEntryTV.reloadData()
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
                
                if let obj = entriestList.findEntryByDBIndex(index: entryIndex!){
                    self.selectedEntry = obj
                }
            }
            print(" journalId:  \(String(describing: entryIndex))")

            destinationVC.recievingEntry = self.selectedEntry
            destinationVC.recievingPet = self.pet
            destinationVC.recievingPetId = recievingPetId
            destinationVC.recievingOldVC = self
            
        } else if segue.identifier == segueUnwind{
            
        }
   
    }
    
}

// ADD DETAIL/event
             //destinationVC.recieivingPetName = nameLbl.text
             //destinationVC.recievingPetImg = petImgView.image
 //                        destinationVC.recievingEntryTitle = selectedTitle
 //            destinationVC.recievingEntryId = entryIndex
