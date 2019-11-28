//
//  CreatePetViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class CreatePetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var typeTxtField: UITextField!
    @IBOutlet weak var raceTxtField: UITextField!
    @IBOutlet weak var idTxtField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var neuteredSegment: UISegmentedControl!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    private var male = true
    private var neutered = false
    
    //var pet : Pet?
    private let pets = Pets()
        let alert = UIAlertController(title: "Adding Pet", message: "Your pet was added to your Journal", preferredStyle: .alert)
        let alertError = UIAlertController(title: "Adding Pet Failed", message: "A pet with that name already exists", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //start with name selected
        nameLbl.delegate = self
        typeTxtField.delegate = self
        raceTxtField.delegate = self
        idTxtField.delegate = self
        genderSegment.selectedSegmentIndex = 0
        neuteredSegment.selectedSegmentIndex = 1
        
        //alert msg initialized
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        alertError.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        alertError.setValue(NSAttributedString(string: "Adding Pet Failed", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        
    }
    
    
    @IBAction func savePetBtn(_ sender: Any) {
        
        
        //TODO
        //Birthdate, male bool, neutered

        guard let nameField = nameLbl.text else {
            return
        }
        
        if nameField == ""{
            alertError.message = "Your pet needs a name"
            self.present(self.alertError, animated: true)
            return
        }
        
        guard let typeField = typeTxtField.text else {
            return
        }
        guard let raceField = raceTxtField.text else {
            return
        }
        guard let idField = idTxtField.text else {
            return
        }
        
        guard let birthDate =  birthDatePicker.date as Date? else{
            return
        }
        
        if genderSegment.selectedSegmentIndex == 1 {
            self.male = false
        }else{
            self.male = true
        }
        
        if neuteredSegment.selectedSegmentIndex == 1 {
            self.neutered = true
        } else{
            self.neutered = false
        }
        

        if (pets.addPet(name: nameField, type: typeField, race: raceField, id : idField, male: self.male, neutered: self.neutered, birthDate: birthDate)){
            self.present(self.alert,animated: true)
        } else{
            self.present(self.alertError, animated: true)
        }
        
        print(pets.countPets())

        clearAllFields()
    }
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        clearAllFields()
        goToPetScreen()
    }
    
    func goToPetScreen(){
        self.tabBarController?.selectedIndex = 1
    }
    
    func clearAllFields() {
        self.nameLbl.text = ""
        self.typeTxtField.text = ""
        self.raceTxtField.text = ""
        self.idTxtField.text = ""
        self.genderSegment.selectedSegmentIndex = 0
        self.neuteredSegment.selectedSegmentIndex = 1
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        <#code#>
//    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
