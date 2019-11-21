//
//  PetPopUpViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-15.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class PetPopUpViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var raceLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    
    private let pets = Pets();
    var pet: NSManagedObject?
    
    var recievingPetId : Int?
    var oldVC: PetViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleInnerView()
        
        fillLabels()

    }
    
    func styleInnerView() {
        innerView.layer.borderWidth = 3
        innerView.layer.borderColor = #colorLiteral(red: 0.231372549, green: 0.5215686275, blue: 0.7058823529, alpha: 1)
        innerView.layer.cornerRadius = 5
    }
    
    func fillLabels() {
        
        //print("RECIEVING ID \(recievingPetId)")
        pet = pets.entryPet(index: recievingPetId!)
        
        if let name = pet!.value(forKeyPath: "name") as? String {
            nameLbl.text = name
        }
        if let type = pet!.value(forKeyPath: "type") as? String {
            typeLbl.text = type
        }
        if let race = pet!.value(forKeyPath: "race") as? String {
            raceLbl.text = race
        }
        if let id = pet!.value(forKeyPath: "id") as? String {
            idLbl.text = id
        }
        
        print("PET ON DISPLAY: \(pet)")
        
    }
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func deleteBtnClick(_ sender: Any) {
        
       // print("DELETE PRESSED \(recievingPetId)")
        
        pets.deletePet(index: recievingPetId!)
        oldVC.petsTableView.reloadData()
        
        dismiss(animated: true)
       
        // dismiss(animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)  //Do something in complettion
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
