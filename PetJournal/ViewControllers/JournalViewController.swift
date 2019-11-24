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
    @IBOutlet weak var petImgView: UIImageView!
    
    let segueDetail = "segueToJournalDetail"
    
    private var entry: NSManagedObject?
    
    private var pets = Pets()
    var pet : NSManagedObject?
    var recievingPetId : Int? //In local list
    
    var selectedTitle: String = ""
    var selectedId: Int?
   
    var entryId: Int?
    var newEntry: Bool = false
        
    
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
        } else{
            //todo dismiss back
        }
        
    }
    
    override func viewDidLayoutSubviews() {
          //collectionview filled from bottom
          journalTV.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
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
        
        let alert = UIAlertController(title: "New Journal Entry", message: "Add a title for your new Journal Entry", preferredStyle: .alert)
    
        let alertSaveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            
            guard let txtField = alert.textFields?.first, let title = txtField.text else {
                return
            }
            
            //TODO SAVE DATA, title
            
            //GET NEW ENTRY ID entryId =
            print(title + " saved")
            //self.entryId = NEW ID
            self.selectedTitle = title
            self.newEntry = true
            
            self.journalTV.reloadData()
            
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
        let entryIndex = entry?.value(forKey: "index") as! String
        cell.entryBtn.tag = Int(entryIndex)!
        
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
                entryId = cell.tag
                print("Sender is button")
                if let txt = cell.titleLabel?.text{
                    selectedTitle = txt
                }
                
            } else {
                
                  
            }
            
           // let entryId = (cell as AnyObject).tag

            print(" journalId:  \(String(describing: entryId))")

            
            destinationVC.recievingEntryTitle = selectedTitle
            //send the whole ITEM
            destinationVC.recievingEntryId = entryId
            destinationVC.recieivingPetName = nameLbl.text
            //destinationVC.recievingPetImg = petImgView.image
            destinationVC.recievingPetId = recievingPetId
            destinationVC.recievingOldVC = self
            // i nästa  var recievingOldVC: JournalViewController!
            

        }
        
        

    }
    
    
    
    
   // ADD DETAIL/event

}
