//
//  PetViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import  CoreData

class PetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
 
    @IBOutlet weak var petsTableView: UITableView!
    
    //var pets: [Pet] = []  //[Pet]
    var pet: NSManagedObject?
    private let pets = Pets();
    

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
    
    
    
    //TABLE VIOEW FUNCTIONS
    
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
        cell.tag = cellIndex // btn?

        
        //Make sure the names arnt upside down since we reversed the order of the cv
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
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
