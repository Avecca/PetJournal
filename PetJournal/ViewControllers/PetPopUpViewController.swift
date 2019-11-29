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
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var neuteredLbl: UILabel!
    @IBOutlet weak var birthDateLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var vetVisitTypeLbl: UILabel!
    @IBOutlet weak var vetDateLbl: UILabel!
    @IBOutlet weak var vetView: UIView!
    @IBOutlet weak var petImageView: UIImageView!
    
  
    private let pets = Pets();
    var pet: NSManagedObject?
    var petComingVisit: Visit?
    var formatter = DateFormatter()
    
    var recievingPetId : Int?
    var oldVC: PetViewController!
    
    let segueJournal = "segueToJournal"
    
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
        formatter.locale = Locale(identifier: "sv_SE")
        
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
        if let male = pet!.value(forKeyPath: "male") as? Bool {
            if male{
                genderLbl.text = "Male"
            }else{
                genderLbl.text = "Female"
            }
        }
        if let neutered = pet!.value(forKeyPath: "neutered") as? Bool {
            if neutered{
                neuteredLbl.text = "Yes"
            }else{
                neuteredLbl.text = "No"
            }
        }
        if let birthDate = pet!.value(forKeyPath: "birthDate") as? Date {
            formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
            birthDateLbl.text = formatter.string(from: birthDate)
        }

        if let id = pet!.value(forKeyPath: "id") as? String {
            idLbl.text = id
        }
        
        let petObjs = pet as! Pet
        
        formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd-HH:mm")
        
        
        var nextVisit = ""
        for visit in petObjs.visits! {
            if ((visit as! Visit).date)!.compare(NSDate.now) == ComparisonResult.orderedDescending {
                petComingVisit = (visit as! Visit)
                break;
            }
        }
        if petComingVisit != nil{
        if petComingVisit!.reason != nil {
            vetView.isHidden = false
            
            if petComingVisit!.date != nil {
                nextVisit = formatter.string(from: petComingVisit!.date!)
                vetDateLbl.text = nextVisit
            }
            vetVisitTypeLbl.text = petComingVisit!.reason
        }
        }
        
        petImageView.imageCircle(anyImage: #imageLiteral(resourceName: "paw_print"))
        
        print("PET ON DISPLAY: \(String(describing: pet))")
    }
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func deleteBtnClick(_ sender: Any) {
        
        pets.deletePet(index: recievingPetId!)
        oldVC.petsTableView.reloadData()

        dismiss(animated: true)
       
        // dismiss(animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)  //Do something in complettion
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueJournal && self.recievingPetId != nil {
            
             let destinationVC = segue.destination as! JournalViewController

             destinationVC.recievingPetId = self.recievingPetId

        }
    }

}

//extension UIImageView {
//    public func imageCircle(anyImage: UIImage){
//
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = self.frame.height / 2
//        self.layer.masksToBounds = false
//        self.clipsToBounds = true
//
//        self.image = anyImage
//    }
//
//}
