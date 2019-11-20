//
//  CreateVeterinaryVisitViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import MultiSelectSegmentedControl

class CreateVeterinaryVisitViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var visitDP: UIDatePicker!
    @IBOutlet weak var infoTV: UITextView!
        @IBOutlet weak var petView: UIView!
    @IBOutlet weak var verticalPetMSC: MultiSelectSegmentedControl!

    
    var visitType: [String] = []
    private let pets = Pets();
    var petNames: [String] = [] // [String]()
    var selected : [String] = []
    private var visits = VeterinaryVisits();
    var info = ""
    
    var recievingPetId : Int?
    var recievingCreate = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        fillPicker()
        
        getPetNames()
        verticalPetMSC.items = petNames
        
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
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        typePicker.dataSource = self
        typePicker.delegate = self
        
//        getPetNames()
//        verticalPetMSC.items = petNames
//        verticalPetMSC.setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
//        verticalPetMSC.setTitleTextAttributes([.obliqueness: 0.25], for: .normal)
        
//        for x in petNames {
//            print("petname:  \(x)")
//        }
        
        if !recievingCreate {
            fillForEdit()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("pet id: \(String(describing: recievingPetId))")
        print("create \(recievingCreate)")
    }
    
    

    func fillForEdit(){
        print("EDIT TIME")
        headerLbl.text = "Edit Visit"
        self.saveBtn?.setTitle("Save Changes", for: .normal)
        
    }
    
    
    func getPetNames(){
        
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
               // print("Selected : \(selected)")
            }
            
            if recievingCreate {
                if visits.addVisit(reason: reason, time: date, info: self.info, petNames: selected ) {
                      
                }
                
            } else{
                //TODO
     //           recievingPetId
    //            if visits.editVisit() {
    //                <#code#>
    //            }
                print("EDITING !!!")
            }
            
            //TODO segue

            
        }
    
    
    //Pickerview Delegate, Datasource and functions
    func fillPicker(){
         
         visitType = ["Checkup", "Vaccination",  "Spaying/Neuturing", "Dental", "Planned Procedure", "Other"]
     }
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
    
    
    //MultiSegmentPicker(){
        
    //}
    
    //MultiSegmentPicker

    

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CreateVeterinaryVisitViewController: MultiSelectSegmentedControlDelegate {
    func multiSelect(_ multiSelectSegmentedControl: MultiSelectSegmentedControl, didChange value: Bool, at index: Int) {
        print("\(value) at \(index)")
    }
}
