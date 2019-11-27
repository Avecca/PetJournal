//
//  EntryDetailViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-24.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class EntryDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {



    @IBOutlet weak var detailTv: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var petImgView: UIImageView!
    @IBOutlet weak var entryNameLbl: UILabel!
    
    let segueUnwindJournal = "unwindToJournalSegue"
        
    private var detail: Detail?
    private var details: [Detail]?

    //todo remoce petid
    var recievingPetId : Int? //In local list
    var recievingEntryId: Int32?
    var recievingEntry: Entry?
    var recievingPet : Pet?
    var recievingEntryTitle: String?
    var recievingOldVC: JournalViewController?
    
    
    private let manager = PersistenceManager.shared
    private var detailsList = DetailsList()
    
    private var detailIndex: Int32?
                    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
           //todo fetch data
        self.detailTv.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        detailTv.delegate = self
        detailTv.dataSource = self
            
            
        if recievingPet != nil  && recievingEntry != nil{
                
            entryNameLbl.text = recievingEntry?.subject
            nameLbl.text = recievingPet?.name
            
            fetchAllDetails()
            
            print(recievingEntry.self)
            
            
                
        } else{
            
            self.performSegue(withIdentifier: segueUnwindJournal, sender: self)
               
        }
            
    }
        
    override func viewDidLayoutSubviews() {
              //collectionview filled from bottom
          detailTv.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
      }
    
    private func fetchAllDetails(){
        
        let allDetails = manager.fetchAll(Detail.self)
        detailsList.fillDetailsList(entries: allDetails)
        
        detailIndex = nil
        
        guard let detailsForEntry = self.recievingEntry!.detail?.allObjects as? [Detail] else { return  }
        
        details = detailsForEntry
        
    }
    
    private func createDetail(incidentType : String, info : String?) {
        
        let d = Detail(context: manager.context)
        d.timeStamp = Date()
        
        //TODO really necessary?
       // e.index
        self.detailIndex = 0
        
        if detailsList.countDetails() > 0 {
            for item in detailsList.fetchWholeDetailsList() {
                let x = item.index
                if Int32(x) > self.detailIndex! {
                    self.detailIndex = Int32(x)
                }
            }
        }
        
        self.detailIndex! += 1
        d.index = detailIndex!
        
        d.entry = recievingEntry
        
        print("Sending to context to save " + String(describing: d.self))
        if (manager.saveContext()){
            detailsList.addDetail(detail: d)
            details?.append(d)
        
            detailTv.reloadData()
            print(d.self)
        }
    }
    
    
    

    @IBAction func DeleteAllEntriesClick(_ sender: Any) {
        
        
        //POPUP TO ASK FIRST
       // TODO DELETE ALL DETAILS AND THE ENTRY
        //Unwind
    }
    
    @IBAction func AddDetailClick(_ sender: Any) {

        let alert = UIAlertController(title: "New Detail for \(recievingEntry?.subject ?? "Journal Entry")", message: "Clarify events/details in your Journal Entry", preferredStyle: .alert)
        
        
        alert.addTextField{ (textField) in
            textField.placeholder = "Type of Incident"
            
        }
        alert.addTextField{ (subTxtField) in
            subTxtField.placeholder = "Description/Information"
        }
        
    
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    
        let alertSaveAction = UIAlertAction(title: "Save Detail", style: .default){
                [unowned self] action in
                
            guard let incidentType = alert.textFields!.first!.text else {
                    return
                }
                
            guard let info = alert.textFields?.last?.text else {
                    return
                }

                print("Saving \(incidentType) and \(info)")
            
            
            if( incidentType != ""){
                
                self.createDetail(incidentType: incidentType, info: info)
                
            }


                
        }
        
        alert.addAction(alertSaveAction)
        alert.addAction(alertCancelAction)
        
        present(alert, animated: true)
    }
    

    
        
 
        //Tableview Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = detailTv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EntryDetailTableViewCell
            
        let cellIndex = indexPath.item
        detail = details![cellIndex]
        let detailIndex = detail!.index
        cell.configCell(obj: detail)
        cell.deleteDetailbtn.tag = Int(detailIndex)
    
        //Make sure the names arnt upside down since we reversed the order of the cv
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            
            
        return cell
    }
        


 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue.identifier == segueUnwindJournal {

            let destinationVC = segue.destination as! JournalViewController
            
            destinationVC.recievingPetId = recievingPetId
            
            print("unwind with prepare")
                
        }
    }

}
