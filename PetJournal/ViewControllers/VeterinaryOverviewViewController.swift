//
//  VeterinaryOverviewViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class VeterinaryOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var VeterinaryTV: UITableView!
    
    let segueCreate = "segueToCreateVisit"
    let segueView = "segueToViewVisit"
    
    var visit: NSManagedObject?
    private let veterinaryVisits = VeterinaryVisits();
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        veterinaryVisits.fetchVisits()
        self.VeterinaryTV.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VeterinaryTV.delegate = self
        VeterinaryTV.dataSource = self
        
        
        self.VeterinaryTV.reloadData()
        

    }
    override func viewDidLayoutSubviews() {
          //collectionview filled from bottom
          VeterinaryTV.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
      }
    
//    override func viewDidAppear(_ animated: Bool) {
//        print("VetVisistNo: \(veterinaryVisits.countVisits())")
//        for item in VeterinaryVisitsList.vetList {
//            print(item)
//        }
//    }
    

    
    
    //TableView Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return veterinaryVisits.countVisits()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VeterinaryTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VeterinaryTableViewCell
        
        let cellIndex = indexPath.item
        
        visit = veterinaryVisits.entryVisit(listIndex: cellIndex)!
        cell.configCell(obj: visit)
        let visitIndex = visit?.value(forKey: "index") as! String
        cell.reasonBtn.tag = Int(visitIndex)!
        cell.dateBtn.tag = Int(visitIndex)!
        
        //print("ADDING CELL INDEX: \(visitIndex)")
        
        //Make sure the names arnt upside down since we reversed the order of the cv
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        
        //cell.reasonBtn.tag =  Int(visitIndex)!

        
        
        return cell
    }
    
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let dSegue = segue.destination as! CreateVeterinaryVisitViewController
//

        if segue.identifier == segueCreate  {
            

            dSegue.recievingCreate = true
           

        }
        
        if segue.identifier == segueView {


            let cell = sender as! UIButton
            
            let visitId = cell.tag

            print(" visitId:  \(visitId)")
            
            dSegue.recievingVisitId = visitId
            dSegue.recievingCreate = false
            
        }
        
    }
    
   @IBAction func unwindToHere( segue: UIStoryboardSegue) {
        veterinaryVisits.reOrderVetList()
    
        self.VeterinaryTV.reloadData()
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
