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
        
    private var detail: NSManagedObject?

    //todo remoce petid
    var recievingPetId : Int? //In local list
    var recievingEntryId: Int32?
//    var recieivingPetName: String?
//    var recievingPetImg: UIImage?
    var recievingEntry: Entry?
    var recievingPet : Pet?
    var recievingEntryTitle: String?
  
    var recievingOldVC: JournalViewController?
                    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
           //todo fetch data
        self.detailTv.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        detailTv.delegate = self
        detailTv.dataSource = self
            
            
        if recievingEntryTitle != nil {
                
            entryNameLbl.text = recievingEntryTitle
            nameLbl.text = recievingPet?.name
                
        } else{
               
        }
            
    }
        
    override func viewDidLayoutSubviews() {
              //collectionview filled from bottom
          detailTv.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
      }

    @IBAction func DeleteAllEntriesClick(_ sender: Any) {
        
        
        //POPUP TO ASK FIRST
       // TODO DELETE ALL DETAILS AND THE ENTRY
        //Unwind
    }
    
    @IBAction func AddDetailClick(_ sender: Any) {
        
        //TODO PopUp with new details, type of incident/event, details of event and time
    }
    
        
 
        //Tableview Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = detailTv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EntryDetailTableViewCell
            
        let cellIndex = indexPath.item
            
            
            //TODO
            //entry = veterinaryVisits.entryVisit(listIndex: cellIndex)!
                
        cell.configCell(obj: detail)
        let detailIndex = detail?.value(forKey: "index") as! String
       // cell.entryBtn.tag = Int(entryIndex)!
            
        //print("ADDING CELL INDEX: \(visitIndex)")
    
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
