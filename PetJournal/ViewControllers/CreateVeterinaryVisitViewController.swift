//
//  CreateVeterinaryVisitViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import  MultiSelectSegmentedControl

class CreateVeterinaryVisitViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    @IBOutlet weak var typePicker: UIPickerView!
    
    var visitType = [String]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        fillPicker()
        
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

        
    }
    
    func fillPicker(){
        
        visitType = ["Checkup", "Vaccination",  "Spaying/Neuturing", "Dental", "Planned Procedure", "Other"]
    }
    
    
    //Pickerview Delegate and Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return visitType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return visitType[row]
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
