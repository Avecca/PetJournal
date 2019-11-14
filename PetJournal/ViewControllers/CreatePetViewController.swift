//
//  CreatePetViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class CreatePetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLbl: UITextField!
    

    var pet : Pet?
    private let pets = Pets()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //start with name selected
        nameLbl.delegate = self
        //nameLbl.becomeFirstResponder()
    }
    
    
    @IBAction func savePetBtn(_ sender: Any) {
        
        guard let nameField = nameLbl.text else {
            return
        }
        
        //pet = Pet(name: nameField)
        
       // pets.add(pet: pet!)
        pets.addPet(pet: Pet(name: nameField))
       
        
        //TODO
        print(pets.countPets())
        
        //TODO return to homepage
        //TODO clear all fields
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
