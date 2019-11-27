//
//  EntryDetailTableViewCell.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-24.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class EntryDetailTableViewCell: UITableViewCell {

       // @IBOutlet weak var entryBtn: UIButton!
    @IBOutlet weak var deleteDetailbtn: UIImageView!
    @IBOutlet weak var incidentTypeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var factLbl: UILabel!
    
    
    private  var formatter = DateFormatter()
    
    
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
        
        func configCell(obj: Detail?){  //pet: Pet //Pet
            
            if obj != nil {
                
                
                formatter.locale = Locale(identifier: "sv_SE")
                formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd-HH:mm")
                let type = obj?.category ?? "Unnamed detail"
                let date = obj?.timeStamp ?? Date()
                let fact = obj?.info ?? ""
                
                incidentTypeLbl.text = type
                dateLbl.text = formatter.string(from: date)
                factLbl.text = fact
                
                
                
                
               // nameLbl?.text = name
               // nameBtn?.setTitle(name, for: .normal)
    
            }
            
        }

}
