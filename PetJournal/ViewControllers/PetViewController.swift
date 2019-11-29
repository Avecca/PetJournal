//
//  PetViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class PetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var petsTableView: UITableView!
    
    let segueToPetPopUpId = "segueToPetPopUp"
    
    //var pets: [Pet] = []  //[Pet]
    var pet: NSManagedObject?
    private let pets = Pets()
    
    //TODO make things private

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pets.fetchPets()
        self.petsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to get this to work again, unedit in appdelegate as well
       // self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        
        petsTableView.delegate = self
        petsTableView.dataSource = self
        
        self.petsTableView.reloadData()
        
        //petsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func viewDidLayoutSubviews() {
          //collectionview filled from bottom
          petsTableView.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
      }
    
    
    //TABLE VIEW FUNCTIONS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  pets.countPets()//PetList.petList.count// pets.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = petsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PetTableViewCell
        
        let cellIndex = indexPath.item
        //nameclick.tag = cellindex
        
        pet = pets.entryPet(index: cellIndex)
        cell.configCell(obj: pet)
       // cell.nameLbl.tag = cellIndex // btn?
        cell.nameBtn.tag = cellIndex
        
        //Make sure the names arnt upside down since we reversed the order of the cv
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        return cell
    }
    
    
    //segues
    
    @IBAction func unwindToPets( segue: UIStoryboardSegue) {

      }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        if segue.identifier == segueToPetPopUpId {

            let cell = sender as! UIButton
            
            let petId = cell.tag

            print(" petid:  \(petId)")

            let destinationVC = segue.destination as! PetPopUpViewController

            destinationVC.recievingPetId = petId
            destinationVC.oldVC = self

        }
        
    }


}
