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
    
    var pet : NSManagedObject?
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
        
        //alert msg initialized
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        alertError.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        alertError.setValue(NSAttributedString(string: "Adding Pet Failed", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        
        //nameLbl.becomeFirstResponder()
    }
    
    
    @IBAction func savePetBtn(_ sender: Any) {
        

        guard let nameField = nameLbl.text else {
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
        if nameField == ""{
            alertError.message = "Your pet needs a name"
            self.present(self.alertError, animated: true)
            return
        }
        

       
        if (pets.addPet(name: nameField, type: typeField, race: raceField, id : idField)){
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
