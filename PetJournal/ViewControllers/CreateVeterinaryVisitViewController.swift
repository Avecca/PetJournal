//
//  CreateVeterinaryVisitViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import MultiSelectSegmentedControl
import  CoreData

class CreateVeterinaryVisitViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var saveBtn: RoundedButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var visitDP: UIDatePicker!
    @IBOutlet weak var infoTV: UITextView!
    @IBOutlet weak var petView: UIView!
    @IBOutlet weak var verticalPetMSC: MultiSelectSegmentedControl!
    
    let segueUnwindToVet = "unwindToHereWithSegue"

    
    var visitType: [String] =  ["Checkup", "Vaccination",  "Spaying/Neuturing", "Dental", "Planned Procedure", "Other"]
    private let pets = Pets();
    var petNames: [String] = [] // Exists[String]()
    var selected : [String] = []  //PetNames
    private var visits = VeterinaryVisits();
    var visit: Visit?// NSManagedObject?
    var info = ""
    
    var recievingVisitId : Int?
    var recievingCreate = true
    
    
    override func viewWillAppear(_ animated: Bool) {
       // fillPicker()
        
//        getPetNames()
//        verticalPetMSC.items = petNames
    

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        typePicker.dataSource = self
        typePicker.delegate = self
        
        getPetNames()
        verticalPetMSC.items = petNames
        
        if !recievingCreate {

            fillForEdit()
        }
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        print("pet id: \(String(describing: recievingPetId))")
//        print("create \(recievingCreate)")
//
//
//    }
    
    

    func fillForEdit(){
        
        if recievingVisitId != nil {
            print("EDIT TIME")
            deleteBtn.isHidden = false
            headerLbl.text = "Edit Visit"
            //TODO Rememeber, only works if title type is PLain not Attributed in inspector
            saveBtn.setTitle("Save Changes", for: [])
            saveBtn.backgroundColor = #colorLiteral(red: 1, green: 0.05490196078, blue: 0.02352941176, alpha: 1)
            
            visit = visits.findVisitByDBIndex(index: self.recievingVisitId!) as? Visit
            
            print(visit!)
            
            if visit != nil {
                
                guard let reason = visit!.value(forKeyPath: "reason") else { return  }
                
                guard let time = visit!.value(forKeyPath: "date") else { return  }
                
                var addedInfo = ""
                if let info2 = visit!.value(forKeyPath: "info")  {
                    addedInfo = info2 as! String
                }
                
                var indexes = IndexSet()
                for p in visit!.pets! {
                    let namePet = (p as! Pet).name
                    if let index = petNames.firstIndex(of: namePet){
                        indexes.insert(index)//append(index)
                    }
                }
                
                verticalPetMSC.selectedSegmentIndexes = indexes

                if let reasonIndex = visitType.firstIndex(of: reason as! String){  //of: reason as! String
                    //[self.view addSubview:self.picker];
                    print("reasonIndex: \(reasonIndex)")
                    typePicker.selectRow(reasonIndex, inComponent: 0, animated: true)
                }
                
                visitDP.date = time as! Date
                
                if addedInfo != "" {
                    infoTV.text = addedInfo
                }
            }
            
            print("Visit id IN EDIT: \(String(describing: recievingVisitId))")
            
        } else{
            self.performSegue(withIdentifier: segueUnwindToVet, sender: self)
        }
    }
    
    
    func getPetNames(){
        
        petNames = []
       // print("Trying to get petnames")
        if pets.countPets() > 0 {
            petView.isHidden = false
            for pet in PetList.petList {
                petNames.append((pet.value(forKey: "name") as? String)!)
                print("Adding petname!")
            }
        } else{
            petView.isHidden = true
        }
    }
    
    @IBAction func deleteVisitClicked(_ sender: Any) {
        if !recievingCreate && recievingVisitId != nil {
            
            visits.deleteVisit(index: recievingVisitId!)
        }
    }
    
    
        @IBAction func SaveClicked(_ sender: Any){

            guard let reason = visitType[typePicker.selectedRow(inComponent: 0)] as String? else {
                return
            }

            guard let date = visitDP.date as Date? else {
                return
            }
            
            if infoTV.text != nil {
                info = infoTV.text
            }

            if !petView.isHidden {
                selected = verticalPetMSC.selectedSegmentTitles
                print("Selected : \(selected)")
                //TODO Make this go with
            }
            
            if recievingCreate {
                if visits.addVisit(reason: reason, time: date, info: self.info, petNames: selected ) {
                    print("Visit created")
                      
                }
                
            } else{  //TODO let petnames come with
                //Edit time
                if recievingVisitId != nil {
                    if visits.updateVisits(index: recievingVisitId!, reason: reason, time: date, info: info, petNames: selected) {
                        print("Updated visit with idIndex \(String(describing: recievingVisitId))")
                    }
                }
            }
            //Segue happens
        }
    
    
    //Pickerview Delegate, Datasource and functions

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return visitType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return visitType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        guard let label = pickerView.view(forRow: row, forComponent: component) as? UILabel else {
//            return
//        }
//        label.backgroundColor = #colorLiteral(red: 0.8558072448, green: 0.9056435227, blue: 0.9374967217, alpha: 0.8470588235)
        
    }
    

}
extension CreateVeterinaryVisitViewController: MultiSelectSegmentedControlDelegate {
    func multiSelect(_ multiSelectSegmentedControl: MultiSelectSegmentedControl, didChange value: Bool, at index: Int) {
        print("\(value) at \(index)")
    }
}

//        getPetNames()
//        verticalPetMSC.items = petNames
//        verticalPetMSC.setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
//        verticalPetMSC.setTitleTextAttributes([.obliqueness: 0.25], for: .normal)
        
//        for x in petNames {
//            print("petname:  \(x)")
//        }

//    func fillPicker(){
//
//         visitType = ["Checkup", "Vaccination",  "Spaying/Neuturing", "Dental", "Planned Procedure", "Other"]
//     }

        
//        let labelW = typePicker.frame.width
//
//        //TODO check if works
//        let label: UILabel = UILabel.init(frame:)
//
//            //UILabel.init(frame: (typePicker.frame.origin.x + labelW, 0, labelW, 20 ))
//
//           // UILabel = UILabel.init(frame: CGRectMake(typePicker.frame.origin.x + labelW * CGFloat(index), 0, labelW, 20))
//
//        label.text = "Visit Reason"
//        label.textAlignment = .center
//        typePicker.addSubview(label)



//
//                print("CHecking where exit, reason = \(reason)")
//                let stringReason: String = reason as! String
//
//                var currentIndex = 0
//
//                for type in visitType {
//
//                    if type == stringReason {
//                        break
//                    }
//                    currentIndex += 1
//                }
//                print("Current index \(currentIndex) and no in list = \(visitType.count)")
